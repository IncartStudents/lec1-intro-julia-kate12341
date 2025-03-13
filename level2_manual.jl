# Выболнить большую часть заданий ниже - привести примеры кода под каждым комментарием


#===========================================================================================
1. Переменные и константы, области видимости, cистема типов:
приведение к типам,
конкретные и абстрактные типы,
множественная диспетчеризация,
=#

# Что происходит с глобальной константой PI, о чем предупреждает интерпретатор?
const PI = 3.14159
PI = 3.14
PI
# Нет разницы между константой и переменной, ее тоже можно изменять и использовать. Ругает нас за то что мы меняем значение у имеющегося объекта

# Что происходит с типами глобальных переменных ниже, какого типа `c` и почему?
a = 1
b = 2.0
c = a + b
typeof(c)
# Тип "с" = float64 из-за того, что в сумме одна переменная float

# Что теперь произошло с переменной а? Как происходит биндинг имен в Julia?
a = "foo"
typeof(a)
# переменноая а просто запоминает влаженные в нее данные и может быть любой


# Что происходит с глобальной переменной g и почему? Чем ограничен биндинг имен в Julia?
g::Int = 1
g = "hi"
# Возникает ошибка так как мы внутри обозначили ее тип

function greet()
    g = "hello"
    println(g)
end
greet()

g

# функция позваляет поменять глобально перемную, но только при вызовии ее, после переменная остается такой же какой и была



# Чем отличаются присвоение значений новому имени - и мутация значений?
v = [1,2,3]
z = v
v[1] = 3
v = "hello"
v
z
z = "hello"
z
# мы можем не создовать новые переменные и приравнивать к старым. При изменение сторой переменной клонированная не измениться


# Написать тип, параметризованный другим типом
# Тип Any 
cc1:: Any = "hi"
cc1 = 1
cc1 = 1.0


function typy(h)
    h = convert(Any, h)
end
h =1
typy(h)
h = "hello"
typy(h)
h = 2.0






#=
Написать функцию для двух аругментов, не указывая их тип,
и вторую функцию от двух аргментов с конкретными типами,
дать пример запуска
=#
a = 1
b = 2.0

function without_type(a, b)
    c = a + b
    return c
end

without_type(a, b)

b = 1

function with_type(a::Int, b::Int)
    c = a + b
    return c
end

with_type(a, b)


#=
Абстрактный тип - ключевое слово? abstract type не могут быть дочерними и от них нельзя создавать новые объекты Number: AbstractFloat
Примитивный тип - ключевое слово?  primitive type имеют заданный фиксированный размер памяти Int; Float
Композитный тип - ключевое слово? struct состоят из нуля или более полей Complex; Rational
=#

#=
Написать один абстрактный тип и два его подтипа (1 и 2)
Написать функцию над абстрактным типом, и функцию над её подтипом-1
Выполнить функции над объектами подтипов 1 и 2 и объяснить результат
(функция выводит произвольный текст в консоль)
=#
import Pkg
using AbstractTrees
AbstractTrees.children(t::Type) = subtypes(t)
print_tree(Number)

#  Определение абстрактного типа и его подтипов
abstract type AbstractAnimal end
# Подтип-1
struct Dog <: AbstractAnimal
    name::String
end

# Подтип-2
struct Cat <: AbstractAnimal
    name::String
end

# Функция над абстрактным типом

dog = Dog("Doge")
cat = Cat("Cate")
# функция для всех типов
function make_sound(animal::AbstractAnimal)
    println("Это животное")
end
# функция для одного типа
function the_dog(animal::Dog)
    println("Это собака")
end


make_sound(dog) 
make_sound(cat) 
the_dog(dog)
the_dog(cat) # тут выводит ошибку так как не евляется этим типом функция не выполняется

# назовем функции одинаково
function make_sound(animal::AbstractAnimal)
    println("Это животное")
end
# функция для одного типа
function make_sound(animal::Dog)
    println("Это собака")
end


make_sound(dog) 
make_sound(cat) 

# Для собаки выполняется функция предназначенная для его типа, для всех остальных общий








#===========================================================================================
2. Функции:
лямбды и обычные функции,
переменное количество аргументов,
именованные аргументы со значениями по умолчанию,
кортежи
=#

# Пример обычной функции

# Пример лямбда-функции (аннонимной функции)

# Пример функции с переменным количеством аргументов

# Пример функции с именованными аргументами

# Функции с переменным кол-вом именованных аргументов

#=
Передать кортеж в функцию, которая принимает на вход несколько аргументов.
Присвоить кортеж результату функции, которая возвращает несколько аргументов.
Использовать splatting - деструктуризацию кортежа в набор аргументов.
=#


#===========================================================================================
3. loop fusion, broadcast, filter, map, reduce, list comprehension
=#

#=
Перемножить все элементы массива
- через loop fusion и
- с помощью reduce
=#

#=
Написать функцию от одного аргумента и запустить ее по всем элементам массива
с помощью точки (broadcast)
c помощью map
c помощью list comprehension
указать, чем это лучше явного цикла?
=#

# Перемножить вектор-строку [1 2 3] на вектор-столбец [10,20,30] и объяснить результат


# В одну строку выбрать из массива [1, -2, 2, 3, 4, -5, 0] только четные и положительные числа


# Объяснить следующий код обработки массива names - что за number мы в итоге определили?
using Random
Random.seed!(123)
names = [rand('A':'Z') * '_' * rand('0':'9') * rand([".csv", ".bin"]) for _ in 1:100]
# ---
same_names = unique(map(y -> split(y, ".")[1], filter(x -> startswith(x, "A"), names)))
numbers = parse.(Int, map(x -> split(x, "_")[end], same_names))
numbers_sorted = sort(numbers)
number = findfirst(n -> !(n in numbers_sorted), 0:9)

# Упростить этот код обработки:


#===========================================================================================
4. Свой тип данных на общих интерфейсах
=#

#=
написать свой тип ленивого массива, каждый элемент которого
вычисляется при взятии индекса (getindex) по формуле (index - 1)^2
=#

#=
Написать два типа объектов команд, унаследованных от AbstractCommand,
которые применяются к массиву:
`SortCmd()` - сортирует исходный массив
`ChangeAtCmd(i, val)` - меняет элемент на позиции i на значение val
Каждая команда имеет конструктор и реализацию метода apply!
=#
abstract type AbstractCommand end
apply!(cmd::AbstractCommand, target::Vector) = error("Not implemented for type $(typeof(cmd))")


# Аналогичные команды, но без наследования и в виде замыканий (лямбда-функций)


#===========================================================================================
5. Тесты: как проверять функции?
=#

# Написать тест для функции


#===========================================================================================
6. Дебаг: как отладить функцию по шагам?
=#

#=
Отладить функцию по шагам с помощью макроса @enter и точек останова
=#


#===========================================================================================
7. Профилировщик: как оценить производительность функции?
=#

#=
Оценить производительность функции с помощью макроса @profview,
и добавить в этот репозиторий файл со скриншотом flamechart'а
=#
function generate_data(len)
    vec1 = Any[]
    for k = 1:len
        r = randn(1,1)
        append!(vec1, r)
    end
    vec2 = sort(vec1)
    vec3 = vec2 .^ 3 .- (sum(vec2) / len)
    return vec3
end

@time generate_data(1_000_000);


# Переписать функцию выше так, чтобы она выполнялась быстрее:


#===========================================================================================
8. Отличия от матлаба: приращение массива и предварительная аллокация?
=#

#=
Написать функцию определения первой разности, которая принимает и возвращает массив
и для каждой точки входного (x) и выходного (y) выходного массива вычисляет:
y[i] = x[i] - x[i-1]
=#

#=
Аналогичная функция, которая отличается тем, что внутри себя не аллоцирует новый массив y,
а принимает его первым аргументом, сам массив аллоцируется до вызова функции
=#

#=
Написать код, который добавляет элементы в конец массива, в начало массива,
в середину массива
=#


#===========================================================================================
9. Модули и функции: как оборачивать функции внутрь модуля, как их экспортировать
и пользоваться вне модуля?
=#


#=
Написать модуль с двумя функциями,
экспортировать одну из них,
воспользоваться обеими функциями вне модуля
=#
module Foo
    #export ?
end
# using .Foo ?
# import .Foo ?


#===========================================================================================
10. Зависимости, окружение и пакеты
=#

# Что такое environment, как задать его, как его поменять во время работы?

# Что такое пакет (package), как добавить новый пакет?

# Как начать разрабатывать чужой пакет?

#=
Как создать свой пакет?
(необязательно, эксперименты с PkgTemplates проводим вне этого репозитория)
=#


#===========================================================================================
11. Сохранение переменных в файл и чтение из файла.
Подключить пакеты JLD2, CSV.
=#

# Сохранить и загрузить произвольные обхекты в JLD2, сравнить их

# Сохранить и загрузить табличные объекты (массивы) в CSV, сравнить их


#===========================================================================================
12. Аргументы запуска Julia
=#

#=
Как задать окружение при запуске?
=#

#=
Как задать скрипт, который будет выполняться при запуске:
а) из файла .jl
б) из текста команды? (см. флаг -e)
=#

#=
После выполнения задания Boids запустить julia из командной строки,
передав в виде аргумента имя gif-файла для сохранения анимации
=#
