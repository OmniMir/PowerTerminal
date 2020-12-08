FROM debian:testing

RUN apt-get update && apt-get install -y nodejs npm --no-install-recommends && rm -rf /var/lib/apt/lists/*

RUN npm config set registry http://registry.npmjs.org/
RUN echo 'PS1="\\[\\033[07;37m\\]node@Docker \\w \\$ \\[\\033[00m\\]"' >> ~/.bashrc

WORKDIR /project
