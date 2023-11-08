include("solution_initial.jl")
include("recherche_local.jl")
include("plots.jl")
include("path_relinking.jl")

using Statistics, Distributions

function eval_grasp(C, A, ncolonnes, nbruns, alpha, IterGrasp = 5, verbose=true)
    times_construct = zeros(Float64, nbruns)
    times_opti = zeros(Float64, nbruns)
    times_tot = zeros(Float64, nbruns)
    
    
    
    all_z = []
    all_zCons = []
    all_bests = []
    temp_all_z = []
    temp_all_zCons = []
    temp_bests = []
    
    z_init = []
    z_opti = []
    val_path = []

    all_bests_res = []
    for i in 1:nbruns
        best_x = zeros(ncolonnes)
        best_res = 0
        elite = []
        temp_all_z = []
        temp_all_zCons = []
        temp_bests = []

        rhsCurr = nothing
        startTime = time()
        for _ in 1:IterGrasp
            if time() - startTime > 60 
                break
            end
            start = time()
            x, z = solution_initial_grasp(C, A, ncolonnes, alpha)
            push!(temp_all_zCons, z)
            push!(z_init, copy(z))
            t_construct = time()
            if z > best_res
                best_res = z
                best_x = copy(x)
                if verbose 
                    println("New Best result : ", best_res)
                end
            end
            x, z, Best, rhsCurr = exchange(x, z, C, A)
            push!(temp_all_z, z)
            push!(z_opti, copy(z))
            t_opti = time()
            if z > best_res
                best_res = z
                best_x = copy(x)
                push!(temp_bests, z)
                push!(elite, copy(best_x))
                if verbose 
                    println("New Best result : ", best_res)
                end
            end
            """
            if length(elite) > 1
                Best_elite = copy(elite[end])
                dist = Beta(5,2)
                echantillon = trunc(Int64, rand(dist) * (length(elite)-1)) + 1
                if echantillon == length(elite)
                    echantillon -= 1
                end
                rand_elite = copy(elite[echantillon])
                # println("Best result of the run : ", Best_elite)
                # println("Random elite : ", rand_elite)
    
                #println("EQUAL   ", rand_elite == Best_elite)
                solution, val = path_relinking(rand_elite, Best_elite, C, A, rhsCurr)
                push!(val_path, copy(val))
                if val > best_res
                    best_x = copy(solution)
                    best_res = val
                    push!(elite, best_x)
                    push!(temp_bests, best_res)
                    if verbose 
                        println("New Best Path Relinking ", val)
                    end
                end
                #println("Solution : ", solution)
                #println("Val : ", val)
                #println("best res ", best_res)
            end
            """

            times_construct[i] = t_construct - start
            times_opti[i] =  t_opti - t_construct
            times_tot[i] = t_opti - start
        end

        # selectionne le meilleur resultat de la run si elite > 1
        push!(all_z, [temp_all_z])
        push!(all_zCons, [temp_all_zCons])
        push!(all_bests, [temp_bests])
        push!(all_bests_res, best_res)
    end

    moy_const = sum(times_construct)/nbruns
    moy_opti = sum(times_opti)/nbruns
    moy_tot = sum(times_tot)/nbruns

    var_cons = var(times_construct)
    var_opti = var(times_opti)

    if verbose 
        println("Nombre de runs : ", nbruns)
        println("Taille de l'instance :  A: ", size(A), "  C: ", ncolonnes)
        println()
        @printf("Variance Construction = %fs\n", var_cons)
        @printf("Variance Optimisation = %fs\n", var_opti)
        println()
        @printf("Temps Construction = %.5fs\n", moy_const)
        @printf("Temps Optimisation = %.5fs\n", moy_opti)
        @printf("Temps Total        = %.5fs\n", moy_tot)

        println("Best Results : ", all_bests_res)
        #plot_grasp(z_init, z_opti)
        plot_path_relinking(z_init, val_path)
    end
    return all_bests_res
end


#DM1
function eval_naive(C, A, ncolonnes, nbruns, verbose=true)
    times_construct = zeros(Float64, nbruns)
    times_opti = zeros(Float64, nbruns)
    times_tot = zeros(Float64, nbruns)
    a_cons_bests = []
    a_opti_bests = []
    z_init = []
    z_opti = []


    for i in 1:nbruns
        start = time()
        x, z, cons_bests = solution_initial_naive(C, A, ncolonnes)
        push!(a_cons_bests, [cons_bests])
        push!(z_init, copy(z))
        t_construct = time()
        x, z, opti_bests = exchange(x, z, C, A)
        push!(a_opti_bests, [opti_bests])
        push!(z_opti, copy(z))  
        t_opti = time()
        times_construct[i] = t_construct - start
        times_opti[i] =  t_opti - t_construct
        times_tot[i] = t_opti - start
    end

    moy_const = sum(times_construct)/nbruns
    moy_opti = sum(times_opti)/nbruns
    moy_tot = sum(times_tot)/nbruns

    var_cons = var(times_construct)
    var_opti = var(times_opti)

    if verbose 
        println("Nombre de runs : ", nbruns)
        println("Taille de l'instance : ", size(A))
        println()
        @printf("Variance Construction = %fs\n", var_cons)
        @printf("Variance Optimisation = %fs\n", var_opti)
        println()
        @printf("Temps Construction = %.5fs\n", moy_const)
        @printf("Temps Optimisation = %.5fs\n", moy_opti)
        @printf("Temps Total        = %.5fs\n", moy_tot)
        plot_naive(z_init, z_opti)
    end
end