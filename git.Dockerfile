FROM debian:latest

RUN apt-get update && apt-get install -y git && rm -rf /var/lib/apt/lists/*

RUN echo 'PS1="\\[\\033[07;37m\\]git@Docker \\w \\$ \\[\\033[00m\\]"' >> ~/.bashrc

WORKDIR /project
