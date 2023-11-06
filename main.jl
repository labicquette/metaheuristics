# edition au terminal formatée façon C
using Printf

include("loadSPP.jl")
include("solution_initial.jl")
include("recherche_local.jl")
include("eval.jl")


C_data, A_data = loadSPP("alldata/pb_2000rnd0700.dat")
nlignes, ncolonnes = size(A_data)

C_init, A_init= loadSPP("alldata/didactic.dat")
lin_init, col_init = size(A_init)

eval_naive(C_init, A_init, col_init, 1)
"""
@show C_data
@show A_data
@show nlignes
@show ncolonnes
"""

C = copy(C_data)
A = copy(A_data)

"""
@show C

x, z = solution_initial(C, A, ncolonnes)

@show x
@show z

x, z = exchange(x, z, C, A)

@show x
@show z

"""

@time eval_naive(C, A, ncolonnes, 1)
