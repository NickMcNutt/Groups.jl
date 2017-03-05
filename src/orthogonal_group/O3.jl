import Base: eye, rand

# Type definitions

immutable OrthogonalGroup{T, N} <: Group
    α::T
    β::T
    γ::T
end

O3{T} = OrthogonalGroup{T, 3}
O3{T}(α::T, β::T, γ::T) = OrthogonalGroup{T, 3}(α, β, γ)

# Identity element

eye(::Type{O3}) = O3(0.0, 0.0, 0.0)

# Random group element

function rand(::Type{O3})
    α, β, γ = 2π*rand(), π*rand(), 2π*rand()
    O3(α, β, γ)
end
