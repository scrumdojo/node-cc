FROM ubuntu:24.04

# ubuntu user has UID=1000 and GID=1000 on ubuntu:24.04
ENV USER=ubuntu

ENV DEBIAN_FRONTEND=noninteractive

# Update package list and install packages
RUN apt-get update && \
    apt-get install -y \
        curl \
        sudo \
        unzip \
    && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Add the user to sudoers for passwordless sudo
RUN echo "$USER ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

USER $USER
WORKDIR /home/$USER
SHELL ["/bin/bash", "-l", "-c"]

# Install oh-my-posh
ARG OMP_INSTALL=/home/$USER/oh_my_posh_install.sh
COPY --chown=$USER:$USER --chmod=755 sh/oh_my_posh_install.sh $OMP_INSTALL
RUN $OMP_INSTALL $OMP_THEME_URL && \
    rm $OMP_INSTALL

# Download oh-my-posh theme
ARG OMP_THEME=/home/$USER/.oh-my-posh/oh_my_posh_theme.sh
COPY --chown=$USER:$USER --chmod=755 sh/oh_my_posh_theme.sh $OMP_THEME
RUN $OMP_THEME
