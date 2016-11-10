abstract Group

immutable UnitaryGroup{T, N} <: Group

immutable OrthogonalGroup{T, N} <: Group
    α::T
    β::T
    γ::T
end

immutable SymmetricGroup{N} <: Group end

typealias O3{T} OrthogonalGroup{T, 3}

O3{T}(α::T, β::T, γ::T) = OrthogonalGroup{T, 3}(α, β, γ)
