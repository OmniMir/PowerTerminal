#Parenting container
FROM debian:testing
#Installing necessary software
RUN apt-get update && apt-get install -y nodejs npm --no-install-recommends && rm -rf /var/lib/apt/lists/*
#Get Registry for NPM
RUN npm config set registry http://registry.npmjs.org/
#Setting handy prompt
RUN echo 'PS1="\\[\\033[07;37m\\]node@Docker \\w \\$ \\[\\033[00m\\]"' >> ~/.bashrc
#Setting working directory
WORKDIR /project
