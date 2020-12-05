FROM debian:testing

RUN apt-get update && apt-get install -y python3 pypy3 && rm -rf /var/lib/apt/lists/*

RUN echo 'PS1="\\[\\033[07;37m\\]python@Docker \\w \\$ \\[\\033[00m\\]"' >> ~/.bashrc

WORKDIR /project
