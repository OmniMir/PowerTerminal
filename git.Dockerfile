#Parenting container
FROM debian:testing
#Installing necessary software
RUN apt-get update && apt-get install -y git && rm -rf /var/lib/apt/lists/*
COPY gh.deb /root/gh.deb
RUN apt-get install -y /root/gh.deb && rm -rf /root/gh.deb
#Setting handy prompt
RUN echo 'PS1="\\[\\033[07;37m\\]git@Docker \\w \\$ \\[\\033[00m\\]"' >> ~/.bashrc
#Setting working directory
WORKDIR /project
