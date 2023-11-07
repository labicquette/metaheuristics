ENV["MPLBACKEND"] = "Agg"
using PyPlot

function plot_naive(zinit, zamelio)
    iteractions = 1:length(zamelio)
    scatter(iteractions, zamelio, color="b", label="Valeurs de z(x) amelioré")
    scatter(iteractions, zinit, color="r", label="Valeurs de z(x) contruit")
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
    scatter(iteractions, zamelio, color="b", label="Valeurs de z(x) amelioré")
    scatter(iteractions, zinit, color="r", label="Valeurs de z(x) contruit")
    plot([1, length(zamelio)], [maximum(zamelio), maximum(zamelio)], color="g", label="Valeur de z(x) optimale")

    xlabel("Nombre d'itérations")
    ylabel("Valeur de z(x)")
    title("Évolution de z(x) au fil des itérations")
    legend()
    
    # Affichez le graphique de manière interactive dans le REPL Julia
    display(gcf())end
