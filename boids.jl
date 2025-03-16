mutable struct WorldState
    boids::Array{Tuple{Float64, Float64, Float64, Float64}, 1}  # (x, y, vx, vy)
    height::Float64
    width::Float64

    function WorldState(n_boids, width, height)
        boids = [(rand() * width, rand() * height, randn(), randn()) for _ in 1:n_boids]
        new(boids, width, height)
    end
end
function update!(state::WorldState)
    perception_radius = 5.0  # Радиус видимости
    max_speed = 2.0          # Максимальная скорость
    max_force = 0.1          # Максимальное ускорение

    for i in 1:length(state.boids)
        x, y, vx, vy = state.boids[i]
        cohesion = (0.0, 0.0)
        separation = (0.0, 0.0)
        alignment = (0.0, 0.0)
        neighbors = 0

        for j in 1:length(state.boids)
            if i != j
                xj, yj, vxj, vyj = state.boids[j]
                dx = xj - x
                dy = yj - y
                distance = sqrt(dx^2 + dy^2)

                if distance < perception_radius
                    neighbors += 1
                    # Cohesion
                    cohesion = cohesion .+ (dx, dy)
                    # Separation
                    separation = separation .- (dx / (distance + 1e-6), dy / (distance + 1e-6))
                    # Alignment
                    alignment = alignment .+ (vxj, vyj)
                end
            end
        end

        if neighbors > 0
            cohesion = cohesion ./ neighbors
            alignment = alignment ./ neighbors
        end

        # Нормализация векторов
        cohesion = normalize(cohesion) .* max_speed
        separation = normalize(separation) .* max_speed
        alignment = normalize(alignment) .* max_speed

        # Применяем правила
        acceleration = (cohesion .+ separation .+ alignment) ./ max_force
        vx, vy = (vx, vy) .+ acceleration
        vx, vy = clamp(vx, -max_speed, max_speed), clamp(vy, -max_speed, max_speed)

        # Обновляем позицию
        x, y = (x, y) .+ (vx, vy)

        # Обработка границ
        x = mod(x, state.width)
        y = mod(y, state.height)

        state.boids[i] = (x, y, vx, vy)
    end
end
function main(ARGS)
    w = 30
    h = 30
    n_boids = 10

    state = WorldState(n_boids, w, h)

    anim = @animate for time in 1:100
        update!(state)
        boids_x = [b[1] for b in state.boids]
        boids_y = [b[2] for b in state.boids]
        scatter(boids_x, boids_y, xlim=(0, state.width), ylim=(0, state.height), markersize=5, legend=false)
    end
    gif(anim, "boids.gif", fps=10)
end
