abstract type Group end

immutable UnitaryGroup{T, N} <: Group end

immutable OrthogonalGroup{T, N} <: Group
    α::T
    β::T
    γ::T
end

immutable SymmetricGroup{N} <: Group
    σ::Vector{Int}
end

SymmetricGroup(σ::Vector{Int}) = SymmetricGroup{length(σ)}(σ)

O3{T} = OrthogonalGroup{T, 3}

O3{T}(α::T, β::T, γ::T) = OrthogonalGroup{T, 3}(α, β, γ)
