exchange(x, z, C_data, A_data) = begin
    # repart des donnees initiales de l'instance numérique
    C = copy(C_data)
    A = copy(A_data)

    # solution courante
    xCurr = copy(x)
    zCurr = z

    bests = []
    # meilleure solution
    xBest = copy(x)
    zBest = z

    # scinde la solution en variable a 0 et variable à 1
    var0 = findall(isequal(0), xCurr[:])
    var1 = findall(isequal(1), xCurr[:])

    # saturation des contraintes : resume dans rhsSol les contraintes saturees
    rhsCurr = zeros(Int, size(A, 1))
    for j in var1
        rhsCurr = rhsCurr + A[:, j]
    end

    # 2-1 exchange
    succes = true
    while succes == true

        j01Best = 0
        j10aBest = 0
        j10bBest = 0
        var1a = var1
        var1b = var1
        succes = false

        # plus profonde descente
        for j10a in var1a
            for j10b in setdiff(var1b, j10a)
                for j01 in var0
                    # test si ameliore zBest actuel
                    # test l'admissibilite de l'ajout d'une variable a la solution
                    if (zCurr - C[j10a] - C[j10b] + C[j01] > zBest) && (findfirst(x -> x>1, rhsCurr - A[:, j10a] - A[:, j10b] + A[:, j01]) == nothing)
                        # meilleur et aucune contraintes violee => un voisin admissible ameliorant
                        j01Best = j01
                        j10aBest = j10a
                        j10bBest = j10b
                        zBest = zCurr - C[j10aBest] - C[j10bBest] + C[j01Best]
                        push!(bests, zBest)
                        succes = true
                    end
                end
            end
        end
        
        if succes
            # maj meilleure solution courante
            var0 = setdiff(var0, j01Best)
            var1 = setdiff(var1, j10aBest)
            var1 = setdiff(var1, j10bBest)
            xBest[j01Best] = 1
            xBest[j10aBest] = 0
            xBest[j10bBest] = 0
            zCurr = zBest
            rhsCurr = rhsCurr - A[:, j10aBest] - A[:, j10bBest] + A[:, j01Best]

            #@printf("    echange %3d %3d %3d ", j10aBest, j10bBest, j01Best)
            #println("| z(x) = ", zBest)
        end
    end

    # 1-1 exchange
    succes = true
    while succes == true

        j01Best = 0
        j10Best = 0
        succes = false

        # plus profonde descente
        for j10 in var1
            for j01 in var0
                # test si ameliore zBest actuel
                # test l'admissibilite de l'ajout d'une variable a la solution
                if (zCurr - C[j10] + C[j01] > zBest) && (findfirst(x -> x > 1, rhsCurr - A[:, j10] + A[:, j01]) == nothing)
                    # meilleur et aucune contraintes violee => un voisin admissible ameliorant
                    j01Best = j01
                    j10Best = j10
                    zBest = zCurr - C[j10Best] + C[j01Best]
                    push!(bests, zBest)
                    succes = true
                end
            end
        end

        if succes
            # maj meilleure solution courante
            var0 = setdiff(var0, j01Best)
            var1 = setdiff(var1, j10Best)
            xBest[j01Best] = 1
            xBest[j10Best] = 0
            zCurr = zBest
            rhsCurr = rhsCurr - A[:, j10Best] + A[:, j01Best]

            #@printf("    echange %3d %3d ", j10Best, j01Best)
            #println("| z(x) = ", zBest)
        end
    end

    return xBest, zBest, bests
end