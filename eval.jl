function eval(dir, nbRuns)
    files = getfname(dir)
    C, A = loadSPP(string("./Data/didactic.dat"))
    s = sum(A, dims=1)
    C = reshape(C,  1, length(C))
    v = C ./ s
    sorted = sortperm(v, dims = 2, rev=true)
    x0, res = optimiz(C, A)
    x0, res = optimiz(C, A)
    time_runs = zeros(length(files))
    for i in 1:length(files)
        C, A = loadSPP(string(dir,files[i]))
        s = sum(A, dims=1)
        C = reshape(C,  1, length(C))
        v = C ./ s
        sorted = sortperm(v, dims = 2, rev=true)
        temp_time = 0
        for j in 1:nbRuns
            start = time()
            x0, xbest, res = optimiz(C, A)
            println("x0 : ",x0, ", xbest: ",xbest)
            temp_time += (time() - start)
        end
        time_runs[i] = temp_time / nbRuns
        #println(time_runs[i])
        #W = transpose(res) .* C
    end
    println(time_runs)
end 