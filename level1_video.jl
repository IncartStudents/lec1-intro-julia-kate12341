# переписать ниже примеры из первого часа из видеолекции: 
# https://youtu.be/4igzy3bGVkQ
# по желанию можно поменять значения и попробовать другие функции


# How to print
println("I`am Kate")

# if write number or function. Out = end line WORK ONLY NUMBER OR FUNCTION
# ; - dont out
123
456;

# see type
my_pi=3.14
typeof(my_pi)

my_answer = 40
typeof(my_answer)

# Syntex math
println(3+3, '\n', 10-3, '\n', 20*5, '\n', 100/10)

# String
s1 = "I am a string"
# or
s2 = """I am a string"""
# Out: "I am a string"

# typeof('a') Out: Char

# work with other type
name = "Kate"
num_fingers = 10
num_toes = 10

println("Hello, ma name is $name.")
println("I have $num_fingers fingers and $num_toes toes. That is $(num_fingers + num_toes)")

# * help conect text
s3 = "How are you?"
s4 = "I am fine"

s3*s4
#or
"$s3$s4";

# Dictirions
myphonebook = Dict("Jenny" => "867-5309", "Ghostbusters" => "555-3345")
# OUT: 
#=
Dict{String, String} with 2 entries:
  "Jenny"        => "867-5309"
  "Ghostbusters" => "555-3345"
=#

# add
myphonebook["Kramer"]="555-FILK"
#Out: "555-FILK"

myphonebook

# delet
pop!(myphonebook, "Kramer")
myphonebook

#tuples
myfavoriteanimals = ("cat", "dog")
# found ror index
myfavoriteanimals[1]

#Array
# String
myfriends = ["Liza", "Nastya", "Pasha", "Anton"]

#int
ff = [1, 2, 3]

#mix
mix = [1, 3.0, "hi"]

# change
myfriends[3] = "Lina"
myfriends

# add
push!(ff, 2)
ff

#delet
pop!(ff)
ff

# Array in Array (Array{String}, Array{Int}, Array{Vector})
favorite = [["book", "sleep", "time"], [1, 2, 4]]

# Matrix on random float
rand(4, 3)

# n = 2 Matrix random
rand(4, 3, 2)

# Loops
let n = 0
    while n < 10
        n += 1
        println(n)
    end
end


let i = 1
    while i<= length(myfriends)
        friend = myfriends[i]
        println("Hi $friend, it`s great to see you!")
        i += 1
    end
end

#for 
for n in 1:10
    println(n)
end

for friend in myfriends
    println("Hi $friend, it`s great to see you!")
end

# add Matrix
m, n = 5, 5
A = zeros(m,n)

for i in 1:m 
    for j in 1:n 
        A[i, j] = i + j 
    end
    
end
A

B = zeros(m,n)

for i in 1:m, j in 1:n 
    B[i, j] = i + j 
end
B

# INt Matrix
c = [i+j for i in 1:m, j in 1:n]

for n in 1:10
    A = [i+j for i in 1:n, j in 1:n]
    # display(A)
end

# Conditionals

x = 3
y = 40

if x>y 
    println("$x > $y")
elseif y>x 
    println("$y > $x")
else
    println("$x = $y")
end

(x > y) && println("$x > $y")
(x<y)&& println("$x < $y")

# function
function sayhi(name)
    println("Hi $name")  
end

sayhi("Mama")

#OR1
sayhi2(name) = println("Hi $name")

#or2
sayhi3 = name -> println("Hi $name")


#Duck-typing in Julia
f = x -> x^2

A = rand(3,3)
f(A)

# SORT 
v = [5, 2, 10]
# sort but not always
sort(v)
println(v)
# sort always
sort!(v)
println(v)

#Broadcasting
f = x -> x^2
V = [1, 2, 3]

# Apply f to each element of A and V using broadcasting
result_V = f.(V)
println(result_V)



