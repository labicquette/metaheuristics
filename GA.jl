function selection()
    #
end

function evaluation()
    ## ????
end

function crossover(pop, next_pop, pop_score)
    #can be optimized 
    next_pop[:,] = copy(pop)
    parents1 = rand(pop, 1:(trunc(Int, length(pop)/2)))
    parents2 = rand(pop, 1:(trunc(Int, length(pop)/2)))
    CrossPoint = rand(1:length(pop[1]-1), trunc(Int, length(pop)/2))
    lengthCP = length(CrossPoint)
    for p in 1:lengthCP
        next_pop[p][1:CrossPoint[p]] = parents1[p][1:CrossPoint[p]]
        next_pop[p][CrossPoint[p]:end] = parents2[p][CrossPoint[p]:end]

        next_pop[p+lengthCP][1:CrossPoint[p]] = parents1[p][1:CrossPoint[p]]
        next_pop[p+lengthCP][CrossPoint[p]:end] = parents2[p][CrossPoint[p]:end]
    end
    #pick couples of random from pop[:,size(pop)/2]
    #pick random location of swap
    #asssign next_pop[rand:] = pop[rand:]
end

function mutation(next_pop, mut_rate)
    print("mutation\n")
    print("next_pop: ", next_pop)
    mask = rand(size(next_pop)) .< mut_rate 
    next_pop[value] .= 1 .- next_pop[value]
    print("next_pop: ", next_pop)
end

function fitness(C, A, pop, pop_score, fitness)
    # fitness is the simple sum of C no weights
    for indiv in 1:length(pop)
        pop_score[indiv] = sum(pop[indiv] .* C) 
    end
end
