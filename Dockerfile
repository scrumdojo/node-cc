FROM ubuntu:24.04

# ubuntu user has UID=1000 and GID=1000 on ubuntu:24.04
ENV USER=ubuntu

USER $USER
WORKDIR /home/$USER
