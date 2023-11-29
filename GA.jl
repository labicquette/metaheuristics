function selection()

end

function evaluation()

end

function crossover(pop, next_pop, pop_score)
    #pick couples of random from pop[:,size(pop)/2]
    #pick random location of swap
    #asssign next_pop[rand:] = pop[rand:]
end

function mutation()

end

function fitness(C, A, pop, pop_score, fitness)
    pop_score[:,] = sum(pop .* C) 
end