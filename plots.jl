ENV["MPLBACKEND"] = "Agg"
using PyPlot

function plot_naive(zinit, zamelio)
    iteractions = 1:length(zamelio)
    scatter(iteractions, zamelio, color="b", markersize=5, label="Valeurs de z(x) amelioré")
    scatter(iteractions, zinit, color="r", markersize=5, label="Valeurs de z(x) contruit")
    plot([1, length(zamelio)], [maximum(zamelio), maximum(zamelio)], color="g", label="Valeur de z(x) optimale")

    xlabel("Nombre d'itérations")
    ylabel("Valeur de z(x)")
    title("Évolution de z(x) au fil des itérations")
    legend()
    
    # Affichez le graphique de manière interactive dans le REPL Julia
    display(gcf())
end


function plot_grasp(zinit, zamelio)
    iteractions = 1:length(zamelio)
    scatter(iteractions, zamelio, color="b", markersize=5, label="Valeurs de z(x) amelioré")
    scatter(iteractions, zinit, color="r", markersize=5, label="Valeurs de z(x) contruit")
    plot([1, length(zamelio)], [maximum(zamelio), maximum(zamelio)], color="g", label="Valeur de z(x) optimale")

    xlabel("Nombre d'itérations")
    ylabel("Valeur de z(x)")
    title("Évolution de z(x) au fil des itérations")
    legend()
    
    # Affichez le graphique de manière interactive dans le REPL Julia
    display(gcf())
end

function plot_path_relinking(val)
    iteractions = 1:length(val)
    scatter(iteractions, val, color="b", markersize=5, label="Valeurs de z(x)")
    plot([1, length(val)], [maximum(val), maximum(val)], color="g", label="Valeur de z(x)")

    xlabel("Nombre d'itérations")
    ylabel("Valeur de z(x)")
    title("Évolution de z(x) au fil des itérations")
    legend()
    
    # Affichez le graphique de manière interactive dans le REPL Julia
    display(gcf())
    
end