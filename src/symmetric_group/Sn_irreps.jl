Shape = Vector{Int}
Tableau = Vector{Vector{Int}}
Tableaux = Vector{Tableau}

function standard_tableaux(table::Vector{Dict{Shape, Tableaux}}, t::Tableau, max_n::Int)
    shape = length.(t)
    n = sum(shape)
    
    if length(table) < n
        push!(table, Dict{Shape, Tableaux}())
    end
    
    push!(get!(table[n], shape, Tableau[]), t)
    
    n == max_n && return table
    
    for row in 1:length(t)
        if row == 1 || length(t[row]) < length(t[row - 1])
            new_t = deepcopy(t)
            push!(new_t[row], n + 1)
            table = standard_tableaux(table, new_t, max_n)
        end
        
        if row == length(t)
            new_t = deepcopy(t)
            push!(new_t, [n + 1])
            table = standard_tableaux(table, new_t, max_n)
        end
    end
    
    return table
end

standard_tableaux(max_n::Int) = standard_tableaux(Dict{Shape, Tableaux}[], [[1]], max_n)

function pos(t::Tableau, i::Int)
    for r in 1:length(t), c in 1:length(t[r])
        if t[r][c] == i
            return r, c
        end
    end
    return 0, 0
end

function adjacent_ρ(table::Vector{Dict{Shape, Tableaux}}, λ::Shape, i::Int)
    n = sum(λ)
    d_λ = length(table[n][λ])
    ρ = zeros(Float64, (d_λ, d_λ))
    
    for (k, t) in enumerate(table[n][λ])
        r_i, c_i = pos(t, i)
        r_j, c_j = pos(t, i - 1)
        d = (c_i - c_j) - (r_i - r_j)
        ρ[k, k] = 1 / d
        if r_i != r_j && c_i != c_j
            new_t = deepcopy(t)
            new_t[r_i][c_i] = i - 1
            new_t[r_j][c_j] = i
            ℓ = findfirst(table[n][λ], new_t)
            ρ[ℓ, k] = √(1 - 1/d^2)
        end
    end
    
    return ρ
end

function yor(table::Vector{Dict{Shape, Tableaux}}, λ::Shape, σ::Vector{Int})
    n = length(σ)
    d_λ = length(table[n][λ])
    
    ν = deepcopy(σ)
    factors = Int[]
    for i in 1:n, j in n:-1:i+1
        if ν[j] < ν[j - 1]
            ν[j-1], ν[j] = ν[j], ν[j-1]
            push!(factors, j)
        end
    end
    
    ρ = eye(d_λ)
    for k in factors
        ρ = adjacent_ρ(table, λ, k) * ρ
    end
    
    return ρ
end

function irrep{N}(g::SymmetricGroup{N}, λ::Vector{Int})
    table = standard_tableaux(N)
    yor(table, λ, g.σ)
end

real_irrep{N}(g::SymmetricGroup{N}, λ::Vector{Int}) = irrep(g, λ)
