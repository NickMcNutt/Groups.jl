abstract Group

immutable OrthogonalGroup{T, N} <: Group
    α::T
    β::T
    γ::T
end

immutable SymmetricGroup{N} <: Group end

typealias O3{T} OrthogonalGroup{T, 3}
