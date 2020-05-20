FROM python:latest

RUN echo 'PS1="\\[\\033[07;37m\\]python@Docker \\w \\$ \\[\\033[00m\\]"' >> ~/.bashrc

WORKDIR /project
