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

# Defining representation

@inbounds function defrep!{N, T}(M::Matrix{T}, g::Sn{N})
    σ = g.σ
    n = size(M, 1)
    for i in 1:n, j in 1:n
        if i == σ[j]
            M[i, j] = one(T)
        else
            M[i, j] = zero(T)
        end
    end

    return M
end

defrep{N}(g::Sn{N}) = defrep!(Matrix{Float64}(N, N), g)
