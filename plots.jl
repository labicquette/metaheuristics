using PyPlot

function plot_naive(cons, opti)
    println("CONS : ", cons)
    for i in cons
        println(i)
    end
    p = plot(cons)
    plot!(p)
    
end


function plot_grasp(cons, z, bests)
    s = length(cons)
    for i in 1:s 
        #println(cons[i])
        #println(z[i])
        println(bests[i][1])
        plot(collect(1:length(bests[i][1])),bests[i][1])
    end
    show()
    println(PyPlot.backend)
end