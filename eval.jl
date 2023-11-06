include("solution_initial.jl")
include("recherche_local.jl")
include("plots.jl")

using Statistics

function eval_grasp(C, A, ncolonnes, nbruns, alpha)
    times_construct = zeros(Float64, nbruns)
    times_opti = zeros(Float64, nbruns)
    times_tot = zeros(Float64, nbruns)
    a_cons_bests = []
    a_opti_bests = []

    for i in 1:nbruns
        start = time()
        x, z, cons_bests = solution_initial(C, A, ncolonnes, alpha)
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

    println("Nombre de runs : ", nbruns)
    println("Taille de l'instance : ")
    println()
    @printf("Variance Construction = %fs\n", var_cons)
    @printf("Variance Optimisation = %fs\n", var_opti)
    println()
    @printf("Temps Construction = %.5fs\n", moy_const)
    @printf("Temps Optimisation = %.5fs\n", moy_opti)
    @printf("Temps Total        = %.5fs\n", moy_tot)
    return times_construct, times_opti, times_tot
end

function eval_naive(C, A, ncolonnes, nbruns)
    times_construct = zeros(Float64, nbruns)
    times_opti = zeros(Float64, nbruns)
    times_tot = zeros(Float64, nbruns)
    a_cons_bests = []
    a_opti_bests = []

    for i in 1:nbruns
        start = time()
        x, z, cons_bests = solution_initial(C, A, ncolonnes)
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

    println("Nombre de runs : ", nbruns)
    println("Taille de l'instance : ", size(A))
    println()
    @printf("Variance Construction = %fs\n", var_cons)
    @printf("Variance Optimisation = %fs\n", var_opti)
    println()
    @printf("Temps Construction = %.5fs\n", moy_const)
    @printf("Temps Optimisation = %.5fs\n", moy_opti)
    @printf("Temps Total        = %.5fs\n", moy_tot)
    return times_construct, times_opti, times_tot
end