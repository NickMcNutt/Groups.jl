# Groups.jl

[![Build Status](https://travis-ci.org/NickMcNutt/Groups.jl.svg?branch=master)](https://travis-ci.org/NickMcNutt/Groups.jl)
[![Coverage Status](https://coveralls.io/repos/NickMcNutt/Groups.jl/badge.svg?branch=master&service=github)](https://coveralls.io/github/NickMcNutt/Groups.jl?branch=master)
[![codecov.io](http://codecov.io/github/NickMcNutt/Groups.jl/coverage.svg?branch=master)](http://codecov.io/github/NickMcNutt/Groups.jl?branch=master)

## Overview

* A generic Julia package for working with [groups](https://en.wikipedia.org/wiki/Group_(mathematics))

* Able to compute linear [group representations](https://en.wikipedia.org/wiki/Group_representation) (including [irreducible representations](https://en.wikipedia.org/wiki/Irreducible_representation))

* Code is focused on high performance and high generality

* Serves as a base library for other group-oriented packages, like [GroupFFT.jl](https://github.com/NickMcNutt/GroupFFT.jl)

* Licensed under the [MIT License](https://opensource.org/licenses/MIT)

## How to install

In Julia:
```julia
Pkg.clone("https://github.com/NickMcNutt/Groups.jl")
```

## Examples

Generate an element of the [orthogonal group](https://en.wikipedia.org/wiki/Orthogonal_group) O(3) using the Euler ZYZ parameterization:

```julia
using Groups

α, β, γ = π/2, π/2, π/2
g = O3(α, β, γ)
```

Compute the unitary irreducible representations of element `g`. For the group O(3), these are [Wigner-D matrices](https://en.wikipedia.org/wiki/Wigner_D-matrix).

```julia
unitary_irreps = [unitary_irrep(g, i) for i in 0:2]
display.(round.(unitary_irreps, 3))
```
```julia
1×1 Array{Complex{Float64},2}:
 1.0+0.0im

3×3 Array{Complex{Float64},2}:
 -0.5+0.0im     0.0+0.707im   0.5+0.0im  
 -0.0-0.707im   0.0+0.0im     0.0-0.707im
  0.5+0.0im    -0.0+0.707im  -0.5-0.0im  

5×5 Array{Complex{Float64},2}:
   0.25-0.0im  -0.0-0.5im  -0.612+0.0im  0.0+0.5im    0.25+0.0im
    0.0+0.5im   0.5-0.0im     0.0+0.0im  0.5+0.0im     0.0-0.5im
 -0.612+0.0im  -0.0-0.0im    -0.5-0.0im  0.0-0.0im  -0.612-0.0im
   -0.0-0.5im   0.5+0.0im    -0.0+0.0im  0.5+0.0im    -0.0+0.5im
   0.25+0.0im  -0.0+0.5im  -0.612-0.0im  0.0-0.5im    0.25+0.0im
```

If we don't want complex numbers, we can generate real irreducible representations instead:

```julia
orthogonal_irreps = [orthogonal_irrep(g, i) for i in 0:2]
display.(round.(orthogonal_irreps, 3))
```

```julia
1×1 Array{Float64,2}:
 1.0

3×3 Array{Float64,2}:
 -1.0  -0.0  0.0
  0.0  -0.0  1.0
 -0.0   1.0  0.0

5×5 Array{Float64,2}:
 -0.0  -1.0  -0.0     0.0  -0.0  
 -1.0   0.0   0.0    -0.0   0.0  
  0.0  -0.0  -0.5    -0.0   0.866
 -0.0   0.0  -0.0     1.0   0.0  
  0.0  -0.0   0.866   0.0   0.5
```

## Functionality

Groups.jl specifies an abstract base type `Group` from which all group types derive. Currently, support is available for the following groups:

```julia
OrthogonalGroup{T, 3}
SpecialOrthogonalGroup{T, 3}
SymmetricGroup{T, N}
```

For convenience, type aliases are provided for groups of low dimension:

```julia
O3{T}
SO3{T}
```

## Contributing

Groups.jl aims to be a comprehensive package that provides base types and linear representations for all of the most widely used groups.
We welcome the support of anyone who wishes to contribute to this project.

#### Completed

* Base types and irreducible representations for O(3), SO(3), and S<sub>n</sub>

#### Todo

* Base types and representations for O(n), U(n), SU(n), SL(n), SE(n), PSL(n)
* Support for other kinds of group representations (standard, faithful, etc.)
* Support for fields other than the complex and real numbers
