---
author: "Na (Michael) Li, PhD."
Time-stamp: "Sun May 30 14:17:44 EDT 2021 (nali@luthien.lan)"
title: "Statistics with Julia"
---


# Introduction

Learning [Julia](https://julialang.org) follow the book [Statistics with Julia](https://statisticswithjulia.org).

## Setup and Interface

Instead of [Jupyter Notebook](https://github.com/JuliaLang/IJulia.jl), My preference is Emacs. Thankfully, with [ESS](https://ess.r-project.org)
supporting Julia and [Polymode](https://polymode.github.io), it is seamless to run the codes
interactively. With [Weave.jl](http://weavejl.mpastell.com/stable/), PDF or HTML output can be generated as
needed. Note that Weave.jl puts all the output of each chunk together, instead of
immediate following each line as in RMarkdown/knitr.

```elisp
(use-package julia-mode)
(use-package ess
  :mode (("\\.jl\\'" . ess-julia-mode)))
(use-package poly-markdown
  :ensure t
  :mode (("\\.[jJ]md\\'" . poly-markdown-mode)))
(add-to-list 'polymode-mode-name-override-alist '(julia . ess-julia))
(require 'smart-compile) ;; https://github.com/zenitani/elisp/blob/master/smart-compile.el
(global-set-key (kbd "<f8>") 'smart-compile)
(add-to-list 'smart-compile-alist '("\\.[jJ]md\\'" . "julia -e 'using Weave; weave(\"%f\")'"))
```

## Julia vs R

Julia was designed from the ground-up as a high-performance scientific computation
language using just-in-time (JIT) compilation, with built-in arrays (vector, matrix).

Coming from an R background, it is helpful to note some rather "peculiar" aspects of
Julia that contributes to its high-performance:

-   Julia has rather strong type system. A function needs to know its argument types
    for *multiple dispatch* to work. Sometimes explicit type conversion (e.g., from
    integer to float) is required.
    
-   Unlike R, arrays are always passed by reference to avoid memory allocation and
    copying. 

-   In addition to functions, loops (`for` or `while`) define their own scopes.

-   A functions is not automatically "vectorized" if not defined to take an array as
    argument. Instead the *dot operator* is needed to "broadcast" a function to each
    element of an array.
    
-   Julia also has built-in support for **macros** which can be convenient.

Examples:
    
```julia
a = [1 3 4];
b = [0.2 0.3 -0.3];
a + b                           # this is vectorized
```

```
1×3 Array{Float64,2}:
 1.2  3.3  3.7
```





This does not work:
```julia
try
    sin(a)
catch
    println("sin() does not have a method for Array type")
end
```

```
sin() does not have a method for Array type
```





This does:
```julia
sin.(a)
```

```
1×3 Array{Float64,2}:
 0.841471  0.14112  -0.756802
```



```julia
macro sayhello(name)
    return :( println("Hello, ", $name, "!") )
end
@sayhello "Charlie"
```

```
Hello, Charlie!
```





## Language Overview

One peculiarity of Julia is that in a function call (e.g., `println()`) the left
parenthesis must immediately follow the function name. Space is not allowed. Perhaps
this is to make the code easier to parse for the just-in-time compiler?

The semicolon `;` at the end suppresses the output. 

One basic data type is `Array`. Note that in Julia, array index starts at 1 (just as
R, Matlab or FORTRAN, but unlike Python or C).

```julia
println("There is more than one way to say hello:")
helloArray = ["Hello", "G'day", "Shallom"];
typeof(helloArray)
for i in 1:3
    println("\t", helloArray[i], " World!")
end
```

```
There is more than one way to say hello:
	Hello World!
	G'day World!
	Shallom World!
```





Comprehension `[f(x) for x in A]` is a short hand for constructing a list or an
array. The "dot" notation "broadcasts" the function to every element of the array.

```julia
println("\nThese squares are just perfect:")
squares = [i^2 for i in 0:10]
for s in squares
    println("  ", s)
end
```

```
These squares are just perfect:
  0
  1
  4
  9
  16
  25
  36
  49
  64
  81
  100
```



```julia
sqrt.(squares)
```

```
11-element Array{Float64,1}:
  0.0
  1.0
  2.0
  3.0
  4.0
  5.0
  6.0
  7.0
  8.0
  9.0
 10.0
```





### Types and Methods

More examples of comprehension.  Julia has a strong type system, which all variables
have types (`Int64` or `Float64`) which helps the compiler. `UnitRange` is a special
type of objects. The last line of the code creates a "tuple", which is immutable. The
parentheses are optional.

```julia
array1 = [(2n+1)^2 for n in 1:5]
array2 = [sqrt(i) for i in array1]
array1 + array2
println(typeof(1:5), ", ", typeof(array1), ", ", typeof(array2))
tp1 = 1:5, array1, array2
tp2 = (1:5, array1, array2)
tp1[2]
```

```
UnitRange{Int64}, Array{Int64,1}, Array{Float64,1}
5-element Array{Int64,1}:
   9
  25
  49
  81
 121
```



```julia
try
    tp2[2] = 3                       # error
catch
    println("Cannot change elements of a tuple.")
end
```

```
Cannot change elements of a tuple.
```





Julia functions are **generic** and have different *methods* depending on the type of
the inputs using *multiple dispatch*.

```julia
methods(sqrt)
```

```
# 20 methods for generic function "sqrt":
[1] sqrt(::Missing) in Base.Math at math.jl:1197
[2] sqrt(a::Float16) in Base.Math at math.jl:1144
[3] sqrt(x::BigInt) in Base.MPFR at mpfr.jl:573
[4] sqrt(a::Complex{Float16}) in Base.Math at math.jl:1145
[5] sqrt(x::BigFloat) in Base.MPFR at mpfr.jl:565
[6] sqrt(z::Complex{var"#s91"} where var"#s91"<:AbstractFloat) in Base at c
omplex.jl:481
[7] sqrt(z::Complex) in Base at complex.jl:506
[8] sqrt(x::Union{Float32, Float64}) in Base.Math at math.jl:572
[9] sqrt(x::Real) in Base.Math at math.jl:599
[10] sqrt(A::StridedArray{var"#s828", 2} where var"#s828"<:Real) in LinearA
lgebra at /Applications/Julia-1.5.app/Contents/Resources/julia/share/julia/
stdlib/v1.5/LinearAlgebra/src/dense.jl:744
[11] sqrt(A::StridedArray{var"#s828", 2} where var"#s828"<:Complex) in Line
arAlgebra at /Applications/Julia-1.5.app/Contents/Resources/julia/share/jul
ia/stdlib/v1.5/LinearAlgebra/src/dense.jl:757
[12] sqrt(A::LinearAlgebra.UpperTriangular) in LinearAlgebra at /Applicatio
ns/Julia-1.5.app/Contents/Resources/julia/share/julia/stdlib/v1.5/LinearAlg
ebra/src/triangular.jl:2577
[13] sqrt(A::LinearAlgebra.UpperTriangular{T,S} where S<:AbstractArray{T,2}
, ::Val{realmatrix}) where {T, realmatrix} in LinearAlgebra at /Application
s/Julia-1.5.app/Contents/Resources/julia/share/julia/stdlib/v1.5/LinearAlge
bra/src/triangular.jl:2597
[14] sqrt(A::LinearAlgebra.UnitUpperTriangular{T,S} where S<:AbstractArray{
T,2}) where T in LinearAlgebra at /Applications/Julia-1.5.app/Contents/Reso
urces/julia/share/julia/stdlib/v1.5/LinearAlgebra/src/triangular.jl:2617
[15] sqrt(A::LinearAlgebra.LowerTriangular) in LinearAlgebra at /Applicatio
ns/Julia-1.5.app/Contents/Resources/julia/share/julia/stdlib/v1.5/LinearAlg
ebra/src/triangular.jl:2635
[16] sqrt(A::LinearAlgebra.UnitLowerTriangular) in LinearAlgebra at /Applic
ations/Julia-1.5.app/Contents/Resources/julia/share/julia/stdlib/v1.5/Linea
rAlgebra/src/triangular.jl:2636
[17] sqrt(A::LinearAlgebra.Hermitian{T,S} where S<:(AbstractArray{var"#s828
",2} where var"#s828"<:T); rtol) where T<:Complex in LinearAlgebra at /Appl
ications/Julia-1.5.app/Contents/Resources/julia/share/julia/stdlib/v1.5/Lin
earAlgebra/src/symmetric.jl:1025
[18] sqrt(A::Union{LinearAlgebra.Hermitian{T,S}, LinearAlgebra.Symmetric{T,
S}} where S; rtol) where T<:Real in LinearAlgebra at /Applications/Julia-1.
5.app/Contents/Resources/julia/share/julia/stdlib/v1.5/LinearAlgebra/src/sy
mmetric.jl:1014
[19] sqrt(D::LinearAlgebra.Diagonal) in LinearAlgebra at /Applications/Juli
a-1.5.app/Contents/Resources/julia/share/julia/stdlib/v1.5/LinearAlgebra/sr
c/diagonal.jl:576
[20] sqrt(J::LinearAlgebra.UniformScaling) in LinearAlgebra at /Application
s/Julia-1.5.app/Contents/Resources/julia/share/julia/stdlib/v1.5/LinearAlge
bra/src/uniformscaling.jl:139
```





### Performance Timing

Timing of codes using a macro (`@` construct).

For the `mean()` function:
```julia
using Statistics
```




Compute 1 million times of the mean of 500 random numbers, where as the random numbers are generated one at a time.

```julia
@time begin
    data = Float64[]
    for _ in 1:10^6
        group = Float64[]
        for _ in 1:5 * 10^2
            push!(group, rand())
        end
        push!(data, mean(group))
    end
    println("98% of the means lie in the estimated range: ",
            (quantile(data, 0.01), quantile(data, 0.99)))
end
```

```
98% of the means lie in the estimated range: (0.4699788912464773, 0.5300008
103434619)
  6.639930 seconds (10.41 M allocations: 7.995 GiB, 9.34% gc time)
```





Note that the function `push!()` use the `!` naming convention to indicate that the
function modifies its argument.

This is much faster to generate 500 random numbers at once.

```julia
@time begin
    data = [mean(rand(5 * 10^2)) for _ in 1:10^6]
    println("98% of the means lie in the estimated range: ",
            (quantile(data, 0.01), quantile(data, 0.99)))
end
```

```
98% of the means lie in the estimated range: (0.4699892752249119, 0.5300595
91265033)
  1.356763 seconds (1.12 M allocations: 3.903 GiB, 21.02% gc time)
```





### Variable Scope

Sometimes it is necessary to use the `global` keyword. Note here a loop (`for` or
`while`) has its own scope and the variable `i` is only available inside the loop.

```julia
data = [1, 2, 3];
s = 0;
beta, gamma = 2, 1;
for i in 1:length(data)
    print(i, " ")
    global s;                   # may not be needed
    s += beta * data[i];
    data[i] *= -1;
end
println("\nSum of data in external scope: ", s)
```

```
1 2 3 
Sum of data in external scope: 12
```





A function has its scope.

```julia
function sumData(beta)
    s = 1
    for i in 1:length(data)
        s += data[i] + beta     # local variable beta
    end
    return s
end
println("Sum of data in a function: ", sumData(beta / 2))
@show s                         # this shows global s
```

```
Sum of data in a function: -2.0
s = 12
12
```





## Crush Course

### Bubble Sort

Note the convention of including `!` in the function name that changes its
argument. Also note that `1:n-1` is the same as `1:(n-1)`, i.e., `:` operator seems
to always evaluate the last.

```julia
function bubbleSort!(a)
    n = length(a)
    for i in 1:n-1
        for j in 1:n-i
            if a[j] > a[j+1]
                a[j], a[j+1] = a[j+1], a[j]
            end
        end
    end
    return a
end
data = [65, 51, 32, 12, 23, 84, 68, 1]
typeof(data)
bubbleSort!(data)
```

```
8-element Array{Int64,1}:
  1
 12
 23
 32
 51
 65
 68
 84
```





By default the function argument `a` is of `Array` type and it works for whatever
elements in the array. In Julia, by default arrays are *passed by reference* so can
be changed in place.

```julia
data2 = [65, 51, 32, 12, 23, 84, 68, 1.0]
typeof(data2)
bubbleSort!(data2)
```

```
8-element Array{Float64,1}:
  1.0
 12.0
 23.0
 32.0
 51.0
 65.0
 68.0
 84.0
```





### Roots of a Polynomial

Here we define a function that returns a (polynomial) function. An argument, `a`,
along with the *splat operator* `...` indicates that the function will accept a comma
separated list of parameters of unspeciﬁed length.

```julia
function polynomialGenerator(a...)
    n = length(a)-1
    poly = function(x)
        return sum([a[i+1] * x^i for i in 0:n])
    end
    return poly
end
polynomial = polynomialGenerator(1,3,-10);
polynomial(3.23)
```

```
-93.63900000000001
```





Functions can be passed as arguments to other functions. Here the `find_zeros()`
function in `Roots` package is used to solve the roots.

```julia
using Roots
zeroVals = find_zeros(polynomial,-10,10);
println("Zeros of the function f(x): ", zeroVals)
```

```
Zeros of the function f(x): [-0.19999999999999998, 0.5]
```





### Markov Chain

This example shows some linear algebra and simulations. In Julia, a matrix is defined
in the same way as in Matlab.

```julia
P = [0.5 0.4 0.1;
     0.3 0.2 0.5;
     0.5 0.3 0.2];
typeof(P)
size(P)                         # dimension of the matrix
length(P)
```

```
9
```





Basic linear algebra operators are defined in an intuitive fashion. The notation
`[1,:]` takes the first row which is a one-dimensional array. Here the goal is to
obtain the stationary distribution.

$$\pi_i = \lim_{n\rightarrow \infty} [P^n]_{j,i}, \quad \text{for any} j.$$

```julia
piProb1 = (P^100)[1,:];
```




A second way is to solve the linear systems of equations:

$$\pi P = \pi$$ 

$$\sum_{i=1}^3 \pi_i = 1$$

`vcat` is for *vertical concatenation* or adding rows.

```julia
using LinearAlgebra             # for I, and eigvecs()
P'                              # transpose
I                               # a special bulitin unit matrix
ones(3)                         # a handy function
A = vcat((P' - I)[1:2,:], ones(3)')
b = [0 0 1]'
piProb2 = A \ b;
```




Note that when an array is assigned to another, it is only by reference so both point
to the same memory. To copy the values into a completely new array, use the `copy()`
function

```julia
a = [1 2 3]
b = a;
c = copy(a);
b[2] = 20;
println("a = ", a)              # a is changed
c[2] = 343;
println("a = ", a)              # not changed
println("c = ", c)
```

```
a = [1 20 3]
a = [1 20 3]
c = [1 343 3]
```





A third method makes use of the *Perron Frobenius Theorem* (?) which implies the
eigenvector corresponding to the eigenvalue of maximal magnitude is proportional to
$\pi$, we ﬁnd this eigenvector and normalize it by the sum of probabilities ($L_1$
norm). Note that these functions return complex values that have to be casted to
float.


```julia
eigVecs = eigvecs(copy(P'))
highestVec = eigVecs[:, findmax(abs.(eigvals(P)))[2]]
piProb3 = Array{Float64}(highestVec) / norm(highestVec, 1);
```




Lastly a simulation is used. 

```julia
using StatsBase                 # for sample(), weights()
numInState = zeros(Int,3)
state = 1;
N = 10^6;
for t in 1:N
    numInState[state] += 1
    global state = sample(1:3, weights(P[state,:]))
end
piProb4 = numInState / N;
```




Show all the results. Note how the vectors are combined into columns of a matrix.

```julia
[piProb1 piProb2 piProb3 piProb4]
```

```
3×4 Array{Float64,2}:
 0.4375  0.4375  0.4375  0.436676
 0.3125  0.3125  0.3125  0.313115
 0.25    0.25    0.25    0.250209
```


