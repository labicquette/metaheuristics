
function crossover(pop, next_pop, pop_score)
    #can be optimized 
    parents1 = rand(1:length(pop), trunc(Int, length(pop)/2))
    parents2 = rand(1:length(pop), trunc(Int, length(pop)/2))
    CrossPoint = rand(2:length(pop[1]), trunc(Int, length(pop)/2))
    lengthCP = length(CrossPoint)
    
    for p in 1:lengthCP
        #child1
        next_pop[p][1:CrossPoint[p]] = pop[parents1[p]][1:CrossPoint[p]]
        next_pop[p][CrossPoint[p]:end] = pop[parents2[p]][CrossPoint[p]:end]
        #child2
        c2 = p+lengthCP-2
        next_pop[c2][1:CrossPoint[p]] = pop[parents2[p]][1:CrossPoint[p]]
        next_pop[c2][CrossPoint[p]:end] = pop[parents1[p]][CrossPoint[p]:end]
    end
    
    #pick couples of random from pop[:,size(pop)/2]
    #pick random location of swap
    #asssign next_pop[rand:] = pop[rand:]
end

function mutation(next_pop, mut_rate)
    #print("mutation\n")
    #println("next_pop: ", next_pop)

    for ind in 1:length(next_pop)
        for ind2 in 1:length(next_pop[ind])
            if rand() < mut_rate
                next_pop[ind][ind2] = 1 - next_pop[ind][ind2]
            end
        end        
    end
end

function fitness(C, A, pop, pop_score)
    # fitness is the simple sum of C no weights
    for indiv in 1:length(pop)
        pop_score[indiv] = sum(pop[indiv] .* C) 
    end
end


function savelites(pop, pop_score, elites, elites_score, nbElite)
    ptpop = 1
    ptel = 1
    res = []
    res_score = []
    println(pop_score)
    println(elites_score)
    while length(res_score) < nbElite
        if elites_score[ptel] >= pop_score[ptpop]
            push!(res, elites[ptel])
            push!(res_score, elites_score[ptel])
            ptel += 1
        elseif elites_score[ptel] < pop_score[ptpop]
            push!(res, pop[ptpop])
            push!(res_score, pop_score[ptpop])
            ptpop += 1
        end
    end
    pop[1:nbElite] = deepcopy(res)
    pop_score[1:nbElite] = deepcopy(res_score)
    elites[:,] = deepcopy(res)
    elites_score[:,] = deepcopy(res_score)

end




function reconstruction(A, C,  pop, pop_score)
    
    for ind in 1:length(pop)
        #test admissible
        destruct(A, C, pop[:,ind], pop_score[:,ind])
        #saturation
    end

end

function destruct(A, C, individu, ind_score)
    len, _ = size(A)
    temp = zeros(len)
    destructed = []
    for iter in 1:length(individu)
        temp[:,] = temp .+ A[:,iter]
        for item in 1:length(temp)
            if temp[item] > 1
                temp[:,] = temp .- A[:,iter]
                individu[iter] = 0
                ind_score -= C[:,iter]
                push!(destructed, iter)
            end
        end
    end
    return destructed
end