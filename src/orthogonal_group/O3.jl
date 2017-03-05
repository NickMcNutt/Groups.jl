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

# Defining representation

@inbounds function defrep!{T}(M::Matrix{T}, g::O3{T})
    α, β, γ = g.α, g.β, g.γ
    M[1, 1] = cos(γ)⋅cos(α)⋅cos(β) - sin(γ)⋅sin(α)
    M[2, 1] = sin(α)⋅cos(γ)⋅cos(β) + sin(γ)⋅cos(α)
    M[3, 1] = -sin(β)⋅cos(γ)
    M[1, 2] = -sin(γ)⋅cos(α)⋅cos(β) - cos(γ)⋅sin(α)
    M[2, 2] = -sin(γ)⋅sin(α)⋅cos(β) + cos(γ)⋅cos(α)
    M[3, 2] = sin(β)⋅sin(γ)
    M[1, 3] = sin(β)⋅cos(α)
    M[2, 3] = sin(β)⋅sin(α)
    M[3, 3] = cos(β)

    return M
end

defrep{T}(g::O3{T}) = defrep!(Matrix{T}(3, 3), g)
