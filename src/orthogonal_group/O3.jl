import Base: eye, rand, *, inv

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

# Hacky and suboptimal. Optimize this. 
# Procedure from
#   http://mathworld.wolfram.com/EulerAngles.html
#   http://mathworld.wolfram.com/NonlinearLeastSquaresFitting.html

function nearest{T}(::Type{O3{T}}, M_defrep::Matrix{T}, tol = T(1e-8)) 
    b = vec(M_defrep)
    tol_sq = tol^2

    α, β, γ = 2π*rand(T), π*rand(T), 2π*rand(T)
    dα, dβ, dγ = T(Inf), T(Inf), T(Inf)
    
    while dα^2 + dβ^2 + dγ^2 > tol_sq
        A = [(-cos(γ)*sin(α)*cos(β) - sin(γ)*cos(α))    (-cos(γ)*cos(α)*sin(β))     (-sin(γ)*cos(α)*cos(β) - cos(γ)*sin(α))
             (cos(α)*cos(γ)*cos(β) - sin(γ)*sin(α))     (-sin(α)*cos(γ)*sin(β))     (-sin(α)*sin(γ)*cos(β) + cos(γ)*cos(α))
             (zero(T))                                  (-cos(β)*cos(γ))            (sin(β)*sin(γ))
             (sin(γ)*sin(α)*cos(β) - cos(γ)*cos(α))     (sin(γ)*cos(α)*sin(β))      (-cos(γ)*cos(α)*cos(β) + sin(γ)*sin(α))
             (-sin(γ)*cos(α)*cos(β) - cos(γ)*sin(α))    (sin(γ)*sin(α)*sin(β))      (-cos(γ)*sin(α)*cos(β) - sin(γ)*cos(α))
             (zero(T))                                  (cos(β)*sin(γ))             (sin(β)*cos(γ))
             (-sin(β)*sin(α))                           (cos(β)*cos(α))             (zero(T))
             (sin(β)*cos(α))                            (cos(β)*sin(α))             (zero(T))
             (zero(T))                                  (-sin(β))                   (zero(T))]

        dα, dβ, dγ = A \ b
        α = mod2pi(α + dα)
        β = mod2pi(2β + 2dβ) / 2
        γ = mod2pi(γ + dγ)
    end

    return O3(α, β, γ)
end

nearest{T}(::Type{O3}, M::Matrix{T}) = nearest(O3{T}, M)

# Multiplication
# Hacky.  Find an analytic expression for multiplying Euler-ZYZ angles
function *{T}(g₁::O3{T}, g₂::O3{T})
    nearest(O3, defrep(g₁) * defrep(g₂))
end

# Inversion
# Hacky. Find an analytic expression for inverting Euler-ZYZ angles
function inv{T}(g::O3{T})
    nearest(O3, inv(defrep(g)))
end
