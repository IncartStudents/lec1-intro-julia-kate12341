module GameOfLife
using Plots

n = 30
m = 30

index = rand(0:1, n, m)

# Функция для подсчета количества живых соседей
function count_neighbors(grid, i, j)
    neighbors = 0
    for x in max(i-1, 1):min(i+1, n)
        for y in max(j-1, 1):min(j+1, m)
            if !(x == i && y == j) && grid[x, y] == 1
                neighbors += 1
            end
        end
    end
    return neighbors
end

# Функция для обновления состояния клеток
function step!(grid)
    new_grid = zeros(Int, n, m)  
    for i in 1:n
        for j in 1:m
            neighbors = count_neighbors(grid, i, j)
            if grid[i, j] == 1
                if neighbors == 2 || neighbors == 3
                    new_grid[i, j] = 1
                else
                    new_grid[i, j] = 0
                end
            else
                if neighbors == 3
                    new_grid[i, j] = 1
                end
            end
        end
    end
    return new_grid
end

function main(ARGS)
    grid = index
    anim = @animate for time in 1:100
        grid = step!(grid) 
        colors = [:black, :yellow] 
        heatmap(grid, c=colors, title="Игра Жизнь", aspect_ratio=1)
    end
    gif(anim, "life.gif", fps=10)
end

export main
end 

using .GameOfLife
GameOfLife.main("")
