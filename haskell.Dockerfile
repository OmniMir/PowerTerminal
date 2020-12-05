FROM debian:testing

RUN apt-get update && apt-get install -y haskell-platform --no-install-recommends && rm -rf /var/lib/apt/lists/*

RUN echo 'PS1="\\[\\033[07;37m\\]haskell@Docker \\w \\$ \\[\\033[00m\\]"' >> ~/.bashrc

WORKDIR /project
