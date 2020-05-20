FROM node:latest

RUN echo 'PS1="\\[\\033[07;37m\\]node@Docker \\w \\$ \\[\\033[00m\\]"' >> ~/.bashrc

WORKDIR /project
