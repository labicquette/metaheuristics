function construct(C, A)
    s = sum(A, dims=1)
    C = reshape(C,  1, length(C))
    v = C ./ s
    sorted = sortperm(v, dims = 2)
    return vec(sorted) 
end

function optimiz(C, A)
    sorted = construct(C,A) #Construction Heuristic
    println(A)
    lenA, _ = size(A)
    temp = zeros(Int64, lenA)
    #temp = A[:, popped]
    res = zeros(length(C))
    best_res = C[sorted[1]]::Int64
    best_arr = zeros(length(C))
    best_arr[sorted[1]] = 1 #x0
    @time xbest, best_arr = multi_start(A, C, sorted, best_res, best_arr, res)
    return C[sorted[1]], xbest, best_arr
end

function multi_start(mat, cons, sorted, best_res, best_arr, res)
    #sorted2 = sorted[:, 2:end]::Matrix{Int64}
    sorted2 = @view(sorted[:, 2:end])::SubArray{Int64}
    temp_best = 0
    best_res = 0
    adm = true
    for i in sorted:: Vector{Int64}
        res .*= 0
        res[i] = 1
        temp = mat[:, i]::Vector{Int64} #2 allocation
        #sorted2 = sorted[:, 1:end .!= i]::Matrix{Int64}#3 allocations
        sorted2 = @view(sorted[:, 1:end .!= i])::SubArray{Int64}
        temp_best = cons[i]::Int64 #0 allocs
        best_res, best_arr = inner_loop(adm, cons, mat, sorted2, temp, temp_best, res, best_arr, best_res) #1 alloc de temps en temps
    end
    return best_res, best_arr
end

function inner_loop(adm::Bool, cons, mat, sorted2::SubArray{Int64}, temp_inner::Vector{Int64}, temp_best, temp_res,best_global_arr, best_global_res)
    #println(typeof(cons), typeof(mat), typeof(temp_best))
    adm = adm
    for j in sorted2::SubArray{Int64}
        adm, temp_inner = rec_opt(adm, mat, temp_inner, j)
        if adm
            temp_res[j] = 1
            temp_best += cons[j]
            #println(temp_best," : ", best_global_res, ", ", cons[j])
            if temp_best > best_global_res
                #println(temp_best," : ", best_global_res)
                best_global_res = temp_best
                best_global_arr = temp_res[:]
            end 
        end
    end
    return best_global_res, best_global_arr
end

function rec_opt(adm::Bool, A::Matrix{Int64}, temp::Vector{Int64}, index::Int64)
    #res = temp[:]::Vector{Int64}
    #res .+= A[:, i]
    #@time for (k, l) in zip(temp, A[:, index])
    for index2 in 1:size(temp,2)
        #if k+l > 1
        if temp[index2] + A[index][index2] > 1
            return false, temp
        end
    end
    #temp .+= A[:, index]
    temp .+= view(A, :, index)
    #println(A[:, index])
    #println(A[:, index] == view(A, :, index))
    return true, temp
    #return rec_test(, temp)
end 
