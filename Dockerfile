FROM ubuntu:24.04

# ubuntu user has UID=1000 and GID=1000 on ubuntu:24.04
ENV USER=ubuntu

ENV DEBIAN_FRONTEND=noninteractive

# Update package list and install packages
RUN apt-get update && \
    apt-get install -y \
        sudo \
    && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Add the user to sudoers for passwordless sudo
RUN echo "$USER ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

USER $USER
WORKDIR /home/$USER
