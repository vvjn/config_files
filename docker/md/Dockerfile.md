FROM nvidia/cuda:10.1-cudnn7-devel-ubuntu16.04

RUN apt-get update && apt-get install -y --no-install-recommends \
        selinux-utils openssh-server vim

# RUN apt-get install -y --no-install-recommends selinux-basics

# RUN apt-get install -y \
#          cmake git curl ca-certificates \
#          libjpeg-dev libpng-dev libtbb2 software-properties-common \
#          autoconf automake autotools-dev ispell \
#          libacl1-dev liblockfile-dev libdbus-1-dev libgif-dev \
#          libgnutls28-dev libgpm-dev libjansson-dev libm17n-dev libncurses5-dev \
#          libselinux1-dev libxml2-dev texinfo openssh-client \
#          texlive-full r-base gfortran unrar wget ffmpeg sudo \
#          gdb rsync tmux apt-utils aptitude dialog apt-file less file iputils-ping
# 
# RUN add-apt-repository ppa:kelleyk/emacs && \
#     apt-get update && \
#     apt-get install -y emacs26-nox

WORKDIR /root
RUN echo "bind '\"\\C-p\": history-search-backward'" >> .bashrc && \
    echo "bind '\"\\C-n\": history-search-backward'" >> .bashrc && \
    echo "export TMOUT=360000" >> .bashrc

WORKDIR /etc/ssh
COPY sshd_config .

WORKDIR /root
RUN mkdir /var/run/sshd
RUN echo 'root:docker!' | chpasswd
# RUN sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# SSH login fix. Otherwise user is kicked off after login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile

WORKDIR /opt
COPY Dockerfile.md .

WORKDIR /workspace
RUN chmod -R a+w .

WORKDIR /root
EXPOSE 22
#CMD ["/usr/sbin/sshd", "-D"]
CMD service ssh start && bash


