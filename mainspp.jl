

using JuMP, GLPK
using LinearAlgebra

include("loadSPP.jl")
include("setSPP.jl")
include("getfname.jl")
include("eval.jl")
include("solvers.jl")
include("parserRAIL.jl")

eval("./bigdata/", 1)