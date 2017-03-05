import Base: eye, rand

# Type definitions

immutable SymmetricGroup{N} <: Group
    σ::Vector{Int}
end

Sn{N} = SymmetricGroup{N}
SymmetricGroup(σ::Vector{Int}) = SymmetricGroup{length(σ)}(σ)

# Identity element

eye{N}(::Type{Sn{N}}) = Sn{N}(1:N)

# Random group element

function rand{N}(::Type{Sn{N}})
    σ = shuffle(1:N)
    Sn(σ)
end
