ENV["MPLBACKEND"] = "Agg"
using PyPlot

function plot_naive(zinit, zamelio)
    iteractions = 1:length(zamelio)
    scatter(iteractions, zamelio, color="b", s=5, label="Valeurs de z(x) amelioré")
    scatter(iteractions, zinit, color="r", s=5, label="Valeurs de z(x) contruit")
    plot([1, length(zamelio)], [maximum(zamelio), maximum(zamelio)], color="g", markersize=5, label="Valeur de z(x) optimale")

    xlabel("Nombre d'itérations")
    ylabel("Valeur de z(x)")
    title("Évolution de z(x) au fil des itérations")
    legend()
    
    # Affichez le graphique de manière interactive dans le REPL Julia
    display(gcf())
end

function plot_grasp(zinit, zamelio)
    iteractions = 1:length(zamelio)
    scatter(iteractions, zamelio, color="b", s=5, label="Valeurs de z(x) amelioré")
    scatter(iteractions, zinit, color="r", s=5, label="Valeurs de z(x) contruit")
    plot([1, length(zamelio)], [maximum(zamelio), maximum(zamelio)], color="g", markersize=5, label="Valeur de z(x) optimale")

    xlabel("Nombre d'itérations")
    ylabel("Valeur de z(x)")
    title("Évolution de z(x) au fil des itérations de GRASP")
    legend()
    
    # Affichez le graphique de manière interactive dans le REPL Julia
    display(gcf())
end

function plot_path_relinking(zinit, val)
    iteractions = 1:length(val)
    iteractionszini = 1:length(zinit)
    scatter(iteractions, val, color="b", s=5, label="Valeurs de z(x)")
    scatter(iteractionszini, zinit, color="r", s=5, label="Valeurs de z(x) contruit")
    plot([1, length(val)], [maximum(val), maximum(val)], color="g", markersize=5, label="Valeur de z(x)")

    xlabel("Nombre d'itérations")
    ylabel("Valeur de z(x)")
    title("Évolution de z(x) au fil des itérations avec Path-Relinking")
    legend()
    
    # Affichez le graphique de manière interactive dans le REPL Julia
    display(gcf())
    
end


function plot_z(zmin, zmean, zmax, max_instance)
    range = 1:length(zmin)
    scatter(range, zmin, color="b", alpha=0.5, marker="+", label="Z min") 
    scatter(range, zmean,  color="orange", alpha=0.5, marker="+", label="Z mean") 
    scatter(range, zmax,  color="g", alpha=0.5, marker="+", label="Z max")
    scatter(range, max_instance, color="r", marker="_", label="Max Instance")
    title("")
    legend() 

    display(gcf())
end

function plot_GA(zinit, elite)
    iteractions = 1:length(elite)
    scatter(iteractions, elite, color="b", s=5, label="Valeurs de z(x) amelioré")
    scatter(iteractions, zinit, color="r", s=5, label="Valeurs de z(x) contruit")
    plot([1, length(elite)], [maximum(elite), maximum(elite)], color="g", markersize=5, label="Valeur de z(x) optimale")

    xlabel("Nombre d'itérations")
    ylabel("Valeur de z(x)")
    title("Évolution de z(x) au fil des itérations de GRASP")
    legend()
    
    # Affichez le graphique de manière interactive dans le REPL Julia
    display(gcf())
end