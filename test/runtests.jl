using Groups
using Base.Test

const n = 1000
srand(100)

# Test unitary irreps for O3
@test begin
    for i in 1:n
        α, β, γ = 2π*rand(), π*rand(), 2π*rand()
        g = O3(α, β, γ)

        for i in 0:4
            unitary_irrep(g, i)
        end
    end

    return true
end

# Test orthogonal irreps for O3
@test begin
    for i in 1:n
        α, β, γ = 2π*rand(), π*rand(), 2π*rand()
        g = O3(α, β, γ)

        for i in 0:4
            orthogonal_irrep(g, i)
        end
    end

    return true
end
