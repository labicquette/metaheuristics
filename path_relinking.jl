function path_relinking(solution1, solution2, nbvoisins, C)
    solutionActuel = copy(solution1)
    # tant que la solution de depart n'est pas egale a la solution d'arrivee
    while solutionActuel != solution2       
        # genere les voisins de la solution de depart
        voisins = []
        for i in 1:nbvoisins
            SolutionModifiee = construction_voisins(solutionActuel)
            if SolutionModifiee != solutionActuel && !in(SolutionModifiee, voisins)
                push!(voisins, SolutionModifiee)
            end
        end
        # selectionne le meilleur voisin
        solutionActuel = best_voisin(voisins, C)

        if solutionActuel > solution2
            break
        end
    end

    return solutionActuel, eval(solutionActuel, C)
end

function construction_voisins(solution)
    # choisis 2 indices de la solution
    indices = randperm(length(solution), 2)
    # echange les valeurs correspondantes
    solution[indices[1]], solution[indices[2]] = solution[indices[2]], solution[indices[1]]
    # renvoie la solution modifiee
    return solution    
end

function best_voisin(voisins, C)
    # initialise la meilleure solution
    best = voisins[1]
    # initialise la meilleure valeur
    bestVal = eval(best, C)
    # pour chaque voisin
    for voisin in voisins
        # si la valeur du voisin est meilleure que la meilleure valeur
        if eval(voisin, C) > bestVal
            # la meilleure valeur devient la valeur du voisin
            bestVal = eval(voisin)
            # la meilleure solution devient le voisin
            best = voisin
        end
    end
    # renvoie la meilleure solution
    return best
    
end

function eval(solution, C)
    # initialise la valeur de la solution
    val = 0
    # pour chaque element de la solution
    for i in 1:length(solution)
        # si l'element est a 1
        if solution[i] == 1
            # ajoute la valeur de l'element a la valeur de la solution
            val += C[i]
        end
    end
    # renvoie la valeur de la solution
    return val 
end