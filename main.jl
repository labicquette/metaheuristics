# edition au terminal formatée façon C
using Printf

include("loadSPP.jl")
include("solution_initial.jl")
include("recherche_local.jl")
include("eval.jl")


C_data, A_data = loadSPP("alldata/pb_100rnd0100.dat")
nlignes, ncolonnes = size(A_data)

C_init, A_init= loadSPP("alldata/didactic.dat")
lin_init, col_init = size(A_init)

alpha = 0.7
IterGrasp = 100

println("Init Compilation")
# eval_naive(C_init, A_init, col_init, 5, false)
eval_grasp(C_init, A_init, col_init, 5, alpha, IterGrasp, false)
println("Fin Compilation\n")

C = copy(C_data)
A = copy(A_data)

# @time eval_naive(C, A, ncolonnes, 5)

@time eval_grasp(C, A, ncolonnes, 5, alpha, IterGrasp)

