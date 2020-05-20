FROM golang:latest

RUN echo 'PS1="\\[\\033[07;37m\\]go@Docker \\w \\$ \\[\\033[00m\\]"' >> ~/.bashrc

WORKDIR /project
