function construct(C, A)
    s = sum(A, dims=1)
    C = reshape(C,  1, length(C))
    v = C ./ s
    sorted = sortperm(v, dims = 2)
    return vec(sorted) 
end

function optimiz(C, A)
    sorted = construct(C,A) #Construction Heuristic
    lenA, _ = size(A)
    temp = zeros(Int64, lenA)
    #temp = A[:, popped]
    res = zeros(length(C))
    best_res = C[sorted[1]]::Int64
    best_arr = zeros(length(C))
    best_arr[sorted[1]] = 1 #x0
    xbest, best_arr = multi_start(A, C, sorted, best_res, best_arr, res)
    return C[sorted[1]], xbest, best_arr
end

function multi_start(mat, cons, sorted, best_res, best_arr, res)
    sorted2 = sorted[:, 2:end]::Matrix{Int64}
    temp_best = 0
    adm = true
    for i in sorted:: Vector{Int64}
        res .*= 0
        res[i] = 1
        temp = mat[:, i]::Vector{Int64}
        sorted2 = sorted[:, 1:end .!= i]::Matrix{Int64}
        temp_best = cons[i]::Int64
        for j in sorted2::Matrix{Int64}
            adm, temp = rec_opt(mat, temp, j)
            if adm 
                res[j] = 1
                temp_best += cons[j]
                if temp_best > best_res
                    best_res = temp_best
                    best_arr = res[:]
                end 
            end
        end
    end
    return best_res, best_arr
end

function rec_opt(A::Matrix{Int64}, temp::Vector{Int64}, i::Int64)
    #res = temp[:]::Vector{Int64}
    #res .+= A[:, i]
    for (k, j) in zip(temp, A[:, i])
        if k+j > 1 
            return false,temp
        end
    end
    return rec_test(res, temp)
end 

function rec_test(res::Vector{Int64}, temp::Vector{Int64})
    if any(x -> x > 1, res)
        return false, temp
    else 
        return true, res
    end
end