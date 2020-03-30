FROM vipin/umd

USER root
WORKDIR /opt
COPY Dockerfile Dockerfile_cmd

WORKDIR /home/vvijayan/.emacs.d
COPY emacs_init.el init.el
COPY emacs_pkgs.el .
RUN chown vvijayan:vvijayan . init.el emacs_pkgs.el

USER vvijayan

WORKDIR /home/vvijayan
RUN curl -o julia.tar.gz -O https://julialang-s3.julialang.org/bin/linux/x64/1.3/julia-1.3.1-linux-x86_64.tar.gz && \
    tar xf julia.tar.gz && \
    mv julia-1.3.1 opt/julia && \
    rm julia.tar.gz

ENV PATH /home/vvijayan/opt/julia/bin:$PATH 

WORKDIR /home/vvijayan/.emacs.d
RUN emacs --batch -l emacs_pkgs.el

WORKDIR /home/vvijayan
RUN echo "alias cs=\"emacsclient -nw\"" >> .bashrc && \
    echo "bind '\"\\C-p\": history-search-backward'" >> .bashrc && \
    echo "bind '\"\\C-n\": history-search-backward'" >> .bashrc && \
    echo "export TMOUT=360000" >> .bashrc && \
    echo "alias jlab=\"jupyter-lab --ip=0.0.0.0 --no-browser\"" >> .bashrc

USER root

WORKDIR /home/vvijayan/.config
COPY dotflake8 flake8
RUN chown vvijayan:vvijayan . flake8

WORKDIR /home/vvijayan
COPY dotcondarc .condarc
COPY conda_pkgs.sh .
COPY julia_pkgs.sh .
COPY datacube_pkgs.sh .
RUN chown vvijayan:vvijayan .condarc conda_pkgs.sh julia_pkgs.sh datacube_pkgs.sh

USER vvijayan
WORKDIR /home/vvijayan
ENTRYPOINT emacs --daemon && bash
