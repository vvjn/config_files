julia -e 'import Pkg; Pkg.update()' && \
    julia -e 'import Pkg; Pkg.add(["MLJ","Flux","GR","Plots","Distributions","Optim","StatsPlots","IJulia","Revise","LightGraphs","DataStructures","DataFrames","Cxx","PyCall","DifferentialEquations","JuMP","JuliaDB","Images","FileIO","BSON","StatsBase","MultivariateStats","ScikitLearn","Optim","Weave","Distances"])'
