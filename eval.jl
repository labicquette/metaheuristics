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
    xbest = zeros(length(files))
    x0 = zeros(length(files))
    for i in 1:length(files)
        C, A = loadSPP(string(dir,files[i]))
        nbvar, nb, C, A = loadInstanceRAIL(string("./rail582"))
        s = sum(A, dims=1)
        C = reshape(C,  1, length(C))
        v = C ./ s
        sorted = sortperm(v, dims = 2, rev=true)
        temp_time = 0
        for j in 1:nbRuns
            start = time()
            @time x0, xbest, res = optimiz(C, A)
            println("x0 : ",x0, ", xbest: ",xbest)
            temp_time += (time() - start)
            #if(j==1)
                #plotRunNaive(files[i], x0, xbest, xbest)
        end
        #plotAnalyseNaive(files[i], x0, xbest, xbest)
        
        time_runs[i] = temp_time / nbRuns
        #println(time_runs[i])
        #W = transpose(res) .* C
    end
    println(time_runs)
    #plotCPUt(files, time_runs)
    #plotRunNaive(files, x0, zbest, zbest)


end 

