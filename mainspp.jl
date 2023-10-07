
using JuMP, GLPK
using LinearAlgebra

include("loadSPP.jl")
include("setSPP.jl")
include("getfname.jl")


println("\nLoading...")
fname = "Data/didactic.dat"
C, A = loadSPP(fname)
@show C
@show A

s = sum(A, dims=1)
C = reshape(C,  1, length(C))
println("C : ", C)
println("S : ", s)
v = C ./ s
sorted = sort(v, dims = 2, rev=true)
println("sort", sorted)
