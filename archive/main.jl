

using JuMP, GLPK
using LinearAlgebra

include("loadSPP.jl")
include("setSPP.jl")
include("getfname.jl")
include("eval.jl")
include("parserRAIL.jl")
include("./solvers/naive.jl")

#paths to instances
big = "./bigdata/"
test = "./test/"

nbRuns = 5

#create optimizers


#execute optimizers
#eval(optimizer, path, nbRuns) 

eval(naiveOpti, "./test/", nbRuns)