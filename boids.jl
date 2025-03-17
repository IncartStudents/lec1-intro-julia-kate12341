module Boids
using Plots

n = 50
m = 50

birds_i = 25 # количество птиц



function eay(cord)
    r = 15
    neighbors = []

    for i in 1:birds_i
        x_i, y_i = cord[i, 1], cord[i, 2]
        current_neighbors = []

        for j in 1:birds_i
            if j != i
                x_j, y_j = cord[j, 1], cord[j, 2]
                distance = sqrt((x_j - x_i)^2 + (y_j - y_i)^2)
                if distance <= r
                    push!(current_neighbors, (x_j, y_j))  # Добавляем координаты соседа
                end
            end
        end
        # Сохраняем соседей текущей птицы
        push!(neighbors, current_neighbors)
    end
    return(neighbors)
    
end



function fly(cord, angles)
    neighbors = eay(cord)  

    for i in 1:birds_i
        if !isempty(neighbors[i])
            centr(cord, neighbors)
        end

        radius = 1  # Радиус круга
        angles[i] += 0.1 + rand(-0.05:0.01:0.05) 
        angle = angles[i]
        new_x = clamp(round(Int, cord[i, 1] + radius * cos(angle)), 1, n)
        new_y = clamp(round(Int, cord[i, 2] + radius * sin(angle)), 1, m)
        if all((new_x != cord[j, 1] || new_y != cord[j, 2]) for j in 1:birds_i if j != i)
            cord[i, 1] = new_x
            cord[i, 2] = new_y
        end
    end

    return cord, angles
end
function centr(cord, neighbors)
    for i in 1:birds_i
        cord_end_x = cord[i, 1]
        cord_end_y = cord[i, 2]
        count = length(neighbors[i])
        for j in neighbors[i]
            cord_end_x += j[1]
            cord_end_y += j[2]
        end

        center_x = cord_end_x / count
        center_y = cord_end_y / count

        if cord[i, 1] > center_x
            new_x = cord[i, 1] - (center_x) * 0.001
        else
            new_x = cord[i, 1] + (center_x) * 0.001
        end
        if cord[i, 2] > center_y
            new_y = cord[i, 2] - (center_y) * 0.001
        else
            new_y = cord[i, 2] + (center_y) * 0.001
        end


        new_x = clamp(new_x, 1, n)
        new_y = clamp(new_y, 1, m)
        new_x = trunc(Int, new_x)
        new_y = trunc(Int, new_y)

        if all((new_x != cord[j, 1] || new_y != cord[j, 2]) for j in 1:birds_i if j != i)
            cord[i, 1] = new_x
            cord[i, 2] = new_y
        end
        
    end
    return(cord)
end

function main(ARGS)
    cord = hcat(rand(1:n, birds_i), rand(1:m, birds_i))  # Генерация случайных начальных координат
    angles = rand(0:2π, birds_i)  # Начальные углы для каждой птицы

    anim = @animate for time in 1:500
        cord, angles = fly(cord, angles)
        scatter(cord[:, 1], cord[:, 2], xlim=(0, n), ylim=(0, m), markersize=5, legend=false)
    end
    gif(anim, "boids.gif", fps=10)
end




end
export main
using .Boids
Boids.main("")

