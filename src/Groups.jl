module Groups

export
    # Group types
    Group,

    OrthogonalGroup, O3,
    SymmetricGroup, Sn,

    # General group methods
    eye,
    rand,
    nearest,
    *,
    inv,
    defrep, defrep!,
    irrep,
    real_irrep,

    # Specific group methods

        # Orthogonal group

        wigner_d̃,
        wigner_D̃,
        wigner_d,
        wigner_D,
        wigner_d̃_matrix,
        wigner_D̃_matrix,
        wigner_d_matrix,
        wigner_D_matrix,

        irrep_O3!,
        irrep_O3,

        # Symmetric group

        standard_tableaux,
        yor

include("types.jl")

include("orthogonal_group/O3.jl")
include("orthogonal_group/O3_irreps.jl")
include("orthogonal_group/O3_real_irreps.jl")

include("symmetric_group/Sn.jl")
include("symmetric_group/Sn_irreps.jl")

end
