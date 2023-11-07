include("solution_initial.jl")
include("recherche_local.jl")
include("plots.jl")

using Statistics

function eval_grasp(C, A, ncolonnes, nbruns, alpha, IterGrasp = 5, verbose=true)
    times_construct = zeros(Float64, nbruns)
    times_opti = zeros(Float64, nbruns)
    times_tot = zeros(Float64, nbruns)
    
    best_res = 0
    best_x = zeros(ncolonnes)
    all_z = []
    all_zCons = []
    all_bests = []
    temp_all_z = []
    temp_all_zCons = []
    temp_bests = []

    for i in 1:nbruns
        temp_all_z = []
        temp_all_zCons = []
        temp_bests = []

        @time for _ in 1:IterGrasp
            start = time()
            x, z = solution_initial_grasp(C, A, ncolonnes, alpha)
            push!(temp_all_zCons, z)
            t_construct = time()
            if z > best_res
                best_res = z
                best_x = copy(x)
                if verbose 
                    println("New Best result : ", best_res)
                end
            end
            x, z = exchange(x, z, C, A)
            push!(temp_all_z, z)
            t_opti = time()
            if z > best_res
                best_res = z
                best_x = copy(x)
                push!(temp_bests, z)
                if verbose 
                    println("New Best result : ", best_res)
                end
            end
            times_construct[i] = t_construct - start
            times_opti[i] =  t_opti - t_construct
            times_tot[i] = t_opti - start
        end
        best_res = 0
        best_x = zeros(ncolonnes)
        push!(all_z, [temp_all_z])
        push!(all_zCons, [temp_all_zCons])
        push!(all_bests, [temp_bests])
    end

    plot_grasp(all_zCons, all_z, all_bests)
    
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

        println("Best Result : ", best_res)
    end
    
end


#DM1
function eval_naive(C, A, ncolonnes, nbruns, verbose=true)
    times_construct = zeros(Float64, nbruns)
    times_opti = zeros(Float64, nbruns)
    times_tot = zeros(Float64, nbruns)
    a_cons_bests = []
    a_opti_bests = []

    for i in 1:nbruns
        start = time()
        x, z, cons_bests = solution_initial_naive(C, A, ncolonnes)
        push!(a_cons_bests, [cons_bests])
        t_construct = time()
        x, z, opti_bests = exchange(x, z, C, A)
        push!(a_opti_bests, [opti_bests])
        t_opti = time()
        times_construct[i] = t_construct - start
        times_opti[i] =  t_opti - t_construct
        times_tot[i] = t_opti - start
    end

    
    #plot_naive(a_cons_bests, a_opti_bests)
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
    end
end