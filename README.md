## Metaheuristique GRASP pour le Set Packing Problem (SPP)
Ce projet implémente une solution basée sur la métaheuristique GRASP (Greedy Randomized Adaptive Search Procedure) pour résoudre le problème du Set Packing (SPP).

# Auteur
Theo Charlot
Nicolas Stucky

# Description
Ce projet propose une implémentation de l'algorithme GRASP pour le Set Packing Problem, avec la possibilité d'expérimenter différents composants additionnels tels que ReactiveGRASP, Path-Relinking, Destroy-and-Repair.

# Structure du Projet
main.jl: Le fichier principal pour executer le programme.
solution_initial.jl: Implémentation de l'heuristique de construction GRASP.
recherche_local.jl: Implémentation de l'amélioration de la solution initial avec k-p exchange.
eval.jl: Le fichier contient les fonctions pour effectuer x runs du programme.
loadSPP.jl: Charge une instance SPP.
alldata/: Répertoire contenant les fichiers des instances du SPP à résoudre.

# Dépandance
Ce projet nécessite Julia (version 1.9) ainsi que les packages suivants :
GLPK (version >= 1.1.3)
PyPlot (version >= 2.11.2)
JuMP (version >= 1.16.0)

Installez les dépendances en utilisant le gestionnaire de paquets de Julia :

julia
Copy code
using Pkg
Pkg.add("GLPK")
Pkg.add("PyPlot")
Pkg.add("JuMP")

# Utilisation
Pour exécuter l'algorithme GRASP avec un composant additionnel spécifique, utilisez la commande suivante :

Juila REPL
include("main.jl")

# Rapport
Les détails sur l'influence des paramètres, les résultats des expérimentations et l'analyse des performances sont inclus dans le rapport LaTeX.
