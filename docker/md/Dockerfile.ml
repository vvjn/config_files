FROM nvidia/cuda:10.1-cudnn7-devel-ubuntu16.04

RUN apt-get update && apt-get install -y \
         build-essential cmake git curl ca-certificates \
         libjpeg-dev libpng-dev libtbb2 software-properties-common \
         autoconf automake autotools-dev ispell \
         libacl1-dev liblockfile-dev libdbus-1-dev libgif-dev \
         libgnutls28-dev libgpm-dev libjansson-dev libm17n-dev libncurses5-dev \
         libselinux1-dev libxml2-dev texinfo openssh-client openssh-server \
         texlive r-base gfortran unrar wget ffmpeg sudo \
         gdb rsync vim tmux apt-utils aptitude dialog apt-file less file iputils-ping && \
    add-apt-repository ppa:kelleyk/emacs && \
    apt-get update && \
    apt-get install -y emacs26-nox && \
    systemctl enable ssh

WORKDIR /root
RUN echo "bind '\"\\C-p\": history-search-backward'" >> .bashrc && \
    echo "bind '\"\\C-n\": history-search-backward'" >> .bashrc && \
    echo "export TMOUT=360000" >> .bashrc

WORKDIR /root
RUN sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN echo "root:docker!" | chpasswd 

WORKDIR /opt
COPY Dockerfile.ml Dockerfile_ml

WORKDIR /workspace
RUN chmod -R a+w .

CMD service ssh start && bash
