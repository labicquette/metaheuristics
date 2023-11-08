# edition au terminal formatée façon C
using Printf, Statistics

include("loadSPP.jl")
include("solution_initial.jl")
include("recherche_local.jl")
include("eval.jl")
include("plots.jl")


C_init, A_init= loadSPP("alldata/didactic.dat")
lin_init, col_init = size(A_init)

alpha = 0.7
IterGrasp = 100

println("Init Compilation")
# eval_naive(C_init, A_init, col_init, 5, false)
eval_grasp(C_init, A_init, col_init, 2, alpha, IterGrasp, false)
println("Fin Compilation\n")

files = ["alldata/pb_100rnd0100.dat",
         "alldata/pb_100rnd0200.dat",
         "alldata/pb_100rnd0300.dat",
         "alldata/pb_100rnd0400.dat",
         "alldata/pb_100rnd0500.dat",
         "alldata/pb_200rnd0100.dat",
         "alldata/pb_200rnd0200.dat",
         #"alldata/pb_200rnd0300.dat",
         "alldata/pb_200rnd0400.dat",
         "alldata/pb_200rnd0500.dat"]
# @time eval_naive(C, A, ncolonnes, 5)
zmin = []
zmean = []
zmax = []

for f in files 
    C_data, A_data = loadSPP(f)
    nlignes, ncolonnes = size(A_data)
    C = copy(C_data)
    A = copy(A_data)
    @time temp = eval_grasp(C, A, ncolonnes, 1, alpha, IterGrasp, false)
    push!(zmin, minimum(temp))
    push!(zmean, mean(temp))
    push!(zmax, maximum(temp)) 
end
@show zmin
@show zmean
@show zmax
plot_z(zmin, zmean, zmax)
