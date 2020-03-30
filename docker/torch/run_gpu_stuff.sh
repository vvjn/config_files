# gast (tensorflow issues)
conda install -y gast=0.2.2 && \
    conda install -y tornado=5 && \
    cd && cd home/xman/code && sh develop.sh && cd && \
    julia -e 'import Pkg; Pkg.add(["Knet","CuArrays"])' && \
    julia -e 'using Flux' && julia -e 'using CuArrays' && julia -e 'using Knet'
