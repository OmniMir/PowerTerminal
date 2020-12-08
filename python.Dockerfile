#Parenting container
FROM debian:testing
#Installing necessary software
RUN apt-get update && apt-get install -y python3 pypy3 && rm -rf /var/lib/apt/lists/*
#Setting handy prompt
RUN echo 'PS1="\\[\\033[07;37m\\]python@Docker \\w \\$ \\[\\033[00m\\]"' >> ~/.bashrc
#Setting working directory
WORKDIR /project
