include("recherche_local.jl")
include("solution_initial.jl")

using Random

function path_relinking(solution1, solution2, nbvoisins, C, A, rhsCurr)
    solutionActuel = copy(solution1)
    solutionOpti = copy(solution2)
    currentSol = copy(solution1)
    currSum = -1
    solOptNb = sum(C .* solutionOpti)
    elite = []
    #println("SOLUT ACTUEL ", solutionActuel)
    #println("SOLUT OPTI   ", solutionOpti)
    #println("DIFF   ", solutionActuel != solutionOpti)
    # tant que la solution de depart n'est pas egale a la solution d'arrivee
    #path relinking : These X.Delorme
    
    for i in 1:length(solutionActuel)
        if solutionActuel[i] != solutionOpti[i]
            solutionActuel[i] = solutionOpti[i]
            currentSol = copy(solutionActuel)
            #specificite de la fonction admissible qui a besoin de plus et minus
            if solutionActuel[i] == 0
                adm = admissible([], [i], C, A, rhsCurr)
            else 
                adm = admissible([i],[], C, A, rhsCurr)
            end
            if adm == nothing
                if !in(currentSol, elite) 
                    currSum = sum(C .* currentSol)
                    if currSum > solOptNb
                        println("1 : CurSum ", currSum, "  " ,solOptNb)
                        currentSol, currSum, optiBest = exchange(currentSol, currSum, C, A)
                        println("2 : CurSum ", currSum, "  " ,solOptNb)
                        push!(elite, copy(currentSol))
                    end
                end
            end
        end
    end

    return copy(currentSol), currSum
end

function construction_voisins(solutionActuel, solutionOpti, A, rhsCurr)
    solution = copy(solutionActuel)
    solopti = copy(solutionOpti)

    while (true) && (solution != solopti)
        rand = Random.rand(1:length(solution))
        #repair
        # if (solution[rand] != solopti[rand]) && (findfirst(x -> x>1, rhsCurr - A[:, rand] + A[:, ]) == nothing)
        #     solution[rand] = solopti[rand]
        #     break
        # end
    end
    # renvoie la solution modifiee
    return solution    
end

function best_voisin(voisins, C)
    # initialise la meilleure solution
    best = copy(voisins[1])
    # initialise la meilleure valeur
    bestVal = valeur(best, C)
    # pour chaque voisin
    for voisin in voisins
        # si la valeur du voisin est meilleure que la meilleure valeur
        # println("BEST   ", bestVal)
        # println("VOISIN ", valeur(voisin, C))
        if valeur(voisin, C) > bestVal
            # la meilleure valeur devient la valeur du voisin
            bestVal = valeur(voisin, C)
            # la meilleure solution devient le voisin
            best = copy(voisin)
        end
    end
    # println("BEST   ", bestVal)
    # println("------------------")
    # renvoie la meilleure solution
    return best    
end

function valeur(solution, C)
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