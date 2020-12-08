#Parenting container
FROM debian:testing
#Installing necessary software
RUN apt-get update && apt-get install -y gcc gdb --no-install-recommends && rm -rf /var/lib/apt/lists/*
#Setting handy prompt
RUN echo 'PS1="\\[\\033[07;37m\\]c++@Docker \\w \\$ \\[\\033[00m\\]"' >> ~/.bashrc
#Setting working directory
WORKDIR /project
