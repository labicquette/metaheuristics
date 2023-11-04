function verify(C, A, current, new, old)
    #current : index for A 
    #new index for C
    #old index for C 

    temp = 0
    temp2 = 0
    #check if solution is better
    for i in eachcol(C[old])
        temp += i
    end
    for i in eachcol(C[new])
        temp2 += i
    end

    if temp > temp2 
        return false
    end
    #check if solution is admissible
    solution 
    tempArr = A[:, current[1]]

    println("temp arr", tempArr)

    for i in 2:size(tempArr,2)
        for j in 1:size(tempArr,2)
            tempArr[i] += A[i][j]
            if tempArr[i] > 2 
                return false
            end
        end
    end
    return true
end

function construct(C, A)
    s = sum(A, dims=1)
    C = reshape(C,  1, length(C))
    v = C ./ s
    sorted = sortperm(v, dims = 2)

    res = zeros(Int64, size(C, 2))
    tempConstruct = zeros(Int64, size(A, 2))
    for i in sorted
        skip = false
        for j in 1:size(A[:,i],2)
            if tempConstruct[j] + A[j,i] > 1
                skip = true
                break
                #exits the j loop and does not perform addition
            end
        end
        if skip 
            continue
        end
        tempConstruct .+= A[i]
        res[i] = 1
    end
    println("tempConstruct", tempConstruct)
    return res
end

function naiveOpti(C, A)
    h0 = construct(C,A) #Construction Heuristic
    println("HO ",h0)
    println(sum(@view(C, h0)))
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



