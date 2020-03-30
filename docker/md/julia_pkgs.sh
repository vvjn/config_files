julia -e 'import Pkg; Pkg.update()' && \
    julia -e 'import Pkg; Pkg.add(["Knet","CuArrays","Flux","GR","Plots","Distributions","Optim","StatsPlots","IJulia","Revise","LightGraphs","DataStructures","DataFrames","Cxx","PyCall","RCall","RDatasets","DifferentialEquations","JuMP","JuliaDB","Images"])' && \
    julia -e 'using GR' && \
    julia -e 'using Plots' && \
    julia -e 'using Distributions' && \
    julia -e 'using Optim' && \
    julia -e 'using StatsPlots' && \
    julia -e 'using IJulia' && \
    julia -e 'using Revise' && \
    julia -e 'using LightGraphs' && \
    julia -e 'using DataStructures' && \
    julia -e 'using DataFrames' && \
    julia -e 'using Cxx' && \
    julia -e 'using PyCall' && \
    julia -e 'using RCall' && \
    julia -e 'using RDatasets' && \
    julia -e 'using DifferentialEquations' && \
    julia -e 'using JuMP' && \
    julia -e 'using JuliaDB' && \
    julia -e 'using Images' && \
    julia -e 'using Flux' && \
    julia -e 'using CuArrays' && \
    julia -e 'using FileIO' && \
    julia -e 'using BSON' && \
    julia -e 'using Knet'
