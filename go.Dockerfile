FROM debian:testing

RUN apt-get update && apt-get install -y golang --no-install-recommends && rm -rf /var/lib/apt/lists/*

RUN echo 'PS1="\\[\\033[07;37m\\]go@Docker \\w \\$ \\[\\033[00m\\]"' >> ~/.bashrc

WORKDIR /project
