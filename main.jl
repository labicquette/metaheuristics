# edition au terminal formatée façon C
using Printf

include("loadSPP.jl")
include("solution_initial.jl")
include("recherche_local.jl")
include("eval.jl")

#C_data, A_data = loadSPP("alldata/didactic.dat")
C_data, A_data = loadSPP("alldata/pb_100rnd0100.dat")
nlignes, ncolonnes = size(A_data)
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

eval_naive(C, A, ncolonnes, 5)
