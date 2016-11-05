# Kostelec & Rockmore

function wigner_d̃{T<:AbstractFloat}(J::Int, M::Int, M′::Int, β::T)
    return if J < max(abs(M), abs(M′))
        zero(T)
    elseif J == 0
        sqrt(1/2)
    elseif J == 1 && M == 0 && M′ == 0
        sqrt(3/2) * cos(β)
    else        
        if J == max(abs(M), abs(M′))
            p = sqrt((2J + 1) / 2)

            if M == J
                p *
                sqrt(factorial(2J) / (factorial(J + M′) * factorial(J - M′))) *
                cos(β/2)^(J + M′) * (-sin(β/2))^(J - M′)
            elseif M == -J
                p *
                sqrt(factorial(2J) / (factorial(J + M′) * factorial(J - M′))) *
                cos(β/2)^(J - M′) * ( sin(β/2))^(J + M′)
            elseif M′ == J
                p *
                sqrt(factorial(2J) / (factorial(J + M ) * factorial(J - M ))) *
                cos(β/2)^(J + M ) * ( sin(β/2))^(J - M )
            else #if M′== -J
                p *
                sqrt(factorial(2J) / (factorial(J + M ) * factorial(J - M ))) *
                cos(β/2)^(J - M ) * (-sin(β/2))^(J + M )
            end
        else
            sqrt((2J + 1) / (2J - 1)) * 
            ((J * (2J - 1)) / sqrt((J^2 - M^2) * (J^2 - M′^2))) * 
            (cos(β) - (M*M′) / ((J - 1) * J)) *
            wigner_d̃(J - 1, M, M′, β) - 
            sqrt((2J + 1) / (2J - 3)) * 
            (sqrt(((J - 1)^2 - M^2) * ((J - 1)^2 - M′^2)) / sqrt((J^2 - M^2) * (J^2 - M′^2))) * 
            (J / (J - 1)) * 
            wigner_d̃(J - 2, M, M′, β)
        end
    end
end

wigner_D̃{T<:AbstractFloat}(J::Int, M::Int, M′::Int, α::T, β::T, γ::T) = exp(-im * M * α) * wigner_d̃(J, M, M′, β) * exp(-im * M′ * γ)

wigner_d{T<:AbstractFloat}(J::Int, M::Int, M′::Int, β::T) = sqrt(2 / (2J + 1)) * wigner_d(J, M, M′, β)
wigner_D{T<:AbstractFloat}(J::Int, M::Int, M′::Int, α::T, β::T, γ::T) = sqrt(2 / (2J + 1)) * wigner_D̃(J, M, M′, α, β, γ)

wigner_d̃_matrix{T<:AbstractFloat}(J::Int, β::T) = [wigner_d̃(J, M, M′, β) for M in -J:J, M′ in -J:J]
wigner_D̃_matrix{T<:AbstractFloat}(J::Int, α::T, β::T, γ::T) = [wigner_D̃(J, M, M′, α, β, γ) for M in -J:J, M′ in -J:J]

wigner_d_matrix{T<:AbstractFloat}(J::Int, β::T) = [wigner_d(J, M, M′, β) for M in -J:J, M′ in -J:J]
wigner_D_matrix{T<:AbstractFloat}(J::Int, α::T, β::T, γ::T) = [wigner_D(J, M, M′, α, β, γ) for M in -J:J, M′ in -J:J]
