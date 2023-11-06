using PyPlot

function plot_naive(cons, opti)
    println("CONS : ", cons)
    for i in cons
        println(i)
    end
    plot(cons)
end