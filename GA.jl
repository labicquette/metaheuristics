function selection()
    #
end

function evaluation()
    ## ????
end

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
    print("mutation\n")
    println("next_pop: ", next_pop)

    # for i in 1:length(next_pop)
    #     print("next_pop[i]: ", next_pop[i])
    #     print("rand: ", rand())
    #     if rand() < mut_rate
    #         next_pop[i] = rand()
    #     end        
    # end
    #println(rand(Float64,size(next_pop)) .< mut_rate)
    mask = rand(Float64,(length(next_pop),length(next_pop[1]))) .< mut_rate
    #println("mask", mask)
    println(next_pop[mask])
    #!!!!!!!!!!!!!
    #FIX : next_pop[mask] -> problem = mask is bitmatrix, 
    #                        doesn't work with Vector{Vector{Int64}}
    #next_pop[mask] .=  1 .- next_pop[mask]
end

function fitness(C, A, pop, pop_score, fitness)
    # fitness is the simple sum of C no weights
    for indiv in 1:length(pop)
        pop_score[indiv] = sum(pop[indiv] .* C) 
    end
end
