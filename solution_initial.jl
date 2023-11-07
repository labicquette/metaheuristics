solution_initial_grasp(C, A, ncolonnes, alpha = 0.5) = begin
    bests = []
    # valeur de la solution
    z = 0

    # variables de la solution
    x = zeros(Int64, ncolonnes)

    # vecteur d'indices des variables
    posVar = collect(1:ncolonnes)

    #indices des lignes du SPP qui sont saturées
    ligneSaturee = Int64[]

    variablesConcernees = findall(isequal(0), vec(sum(A, dims=1)))

    for j in variablesConcernees
        # maj solution (partielle) en fixant a 1 la variable non contrainte
        x[j] = 1
        # maj valeur de la solution (partielle)
        z = z + C[j]
    end

    posVar = posVar[setdiff(1:ncolonnes, variablesConcernees)]
    C = C[setdiff(1:ncolonnes, variablesConcernees)]
    A = A[:, setdiff(1:ncolonnes, variablesConcernees)]

    while (size(A, 1) != 0) && (size(C, 1) != 0)
        # --- Choix glouton ---

        # calcul de l'utilité des variables
        utilite = C ./ vec(sum(A, dims=1))

        # GRASP
        # Calcul de la valeur de Limit
        limit = minimum(utilite) + alpha * (maximum(utilite) - minimum(utilite))

        # Construction de la RCL
        rcl_candidates = findall(x -> x >= limit, utilite)

        if isempty(rcl_candidates)
            break  # Sortie de la boucle si la RCL est vide
        end

        # Sélection d'un élément de la RCL de manière aléatoire
        j_select = rcl_candidates[rand(1:length(rcl_candidates))]

        # mise à jour de la solution courante et de sa valeur
        x[posVar[j_select]] = 1
        z = z + C[j_select]

        # println("ivar     : ", posVar)
        # println("C        : ", C)
        # println("A        : ", A)
        # println("U        : ", utilite)
        # println("j_select : ", j_select)
        # println("-----------")

        # ----- Elimine toutes les variables fixee et reduit l'instance en nombre de colonnes -----

        # identifie les contraintes concernées par la variable choisie (lignes de A barees)
        ligneSaturee = findall(isequal(1), A[:, j_select])

        # identifie les variables concernees par la variable choisie (variables a mettre a 0)
        variablesConcernees = Int64[]
        for i in ligneSaturee # parcours de la colonne selectionnee
            variablesConcernees = union(variablesConcernees, findall(isequal(1), A[i, :])) # lignes de A concernees
        end

        # supprime les colonnes correpondant aux variables fixees
        variablesConcernees = unique(variablesConcernees) # elimine les indices doublons
        posVar = posVar[setdiff(1:end, variablesConcernees)]
        C = C[setdiff(1:end, variablesConcernees)]
        A = A[:, setdiff(1:end, variablesConcernees)]

        # ---- Elimine toutes les contraintes saturées et reduit l'instance en nombre de lignes ----

        A = A[setdiff(1:end, ligneSaturee), :]

        # ---- Elimine les contraintes de A contenant que des zeros (suite aux operations precedentes) ----

        contraintesConcernees = Int64[]
        for lignes in (1:size(A, 1))
            if findfirst(isequal(1), A[lignes, :]) == nothing
                contraintesConcernees = union(contraintesConcernees, lignes)
            end
        end
        A = A[setdiff(1:end, contraintesConcernees), :]
        push!(bests, z)
    end

    # println("z(init) = ", z)

    return x, z, bests
end

solution_initial_naive(C, A, ncolonnes) = begin
    bests = []
    # valeur de la solution
    z = 0

    # variables de la solution
    x = zeros(Int64, ncolonnes)

    # vecteur d'indices des variables
    posVar = collect(1:ncolonnes)

    #indices des lignes du SPP qui sont saturées
    ligneSaturee = Int64[]

    variablesConcernees = findall(isequal(0), vec(sum(A, dims=1)))

    for j in variablesConcernees
        # maj solution (partielle) en fixant a 1 la variable non contrainte
        x[j] = 1
        # maj valeur de la solution (partielle)
        z = z + C[j]
    end

    posVar = posVar[setdiff(1:ncolonnes, variablesConcernees)]
    C = C[setdiff(1:ncolonnes, variablesConcernees)]
    A = A[:, setdiff(1:ncolonnes, variablesConcernees)]

    while (size(A, 1) != 0) && (size(C, 1) != 0)
        # --- Choix glouton ---

        # calcul de l'utilité des variables
        utilite = C ./ vec(sum(A, dims=1))

        # selectionne l'indice de la variable de plus grande utilité
        j_select = argmax(utilite)

        # mise à jour de la solution courante et de sa valeur
        x[posVar[j_select]] = 1
        z = z + C[j_select]

        # println("ivar     : ", posVar)
        # println("C        : ", C)
        # println("A        : ", A)
        # println("U        : ", utilite)
        # println("j_select : ", j_select)
        # println("-----------")

        # ----- Elimine toutes les variables fixee et reduit l'instance en nombre de colonnes -----

        # identifie les contraintes concernées par la variable choisie (lignes de A barees)
        ligneSaturee = findall(isequal(1), A[:, j_select])

        # identifie les variables concernees par la variable choisie (variables a mettre a 0)
        variablesConcernees = Int64[]
        for i in ligneSaturee # parcours de la colonne selectionnee
            variablesConcernees = union(variablesConcernees, findall(isequal(1), A[i, :])) # lignes de A concernees
        end

        # supprime les colonnes correpondant aux variables fixees
        variablesConcernees = unique(variablesConcernees) # elimine les indices doublons
        posVar = posVar[setdiff(1:end, variablesConcernees)]
        C = C[setdiff(1:end, variablesConcernees)]
        A = A[:, setdiff(1:end, variablesConcernees)]

        # ---- Elimine toutes les contraintes saturées et reduit l'instance en nombre de lignes ----

        A = A[setdiff(1:end, ligneSaturee), :]

        # ---- Elimine les contraintes de A contenant que des zeros (suite aux operations precedentes) ----

        contraintesConcernees = Int64[]
        for lignes in (1:size(A, 1))
            if findfirst(isequal(1), A[lignes, :]) == nothing
                contraintesConcernees = union(contraintesConcernees, lignes)
            end
        end
        A = A[setdiff(1:end, contraintesConcernees), :]
        push!(bests, z)
    end

    # println("z(init) = ", z)

    return x, z, bests
end


function admissible(plus, minus, C, A, rhsCurr)
    tempSol = zeros(Int64, length(rhsCurr))
    for i in plus
        tempSol .+= view(A, :, i) 
    end
    for i in minus 
        tempSol .-= view(A, :, i) 
    end
    return findfirst(x -> x>1, rhsCurr + tempSol)
end
