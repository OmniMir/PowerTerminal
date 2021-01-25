#Parenting container
FROM debian:testing
#Installing necessary software
RUN apt-get update && apt-get install -y --no-install-recommends \
	openssh-server \
	&& rm -rf /var/lib/apt/lists/*
#Setting workking user
ENV USER=sshserver
RUN useradd $USER -m -s /bin/bash -g root && \
	echo 'PS1="\\[\\033[07;37m\\]ssh@Docker \\w \\$ \\[\\033[00m\\]"' >> /root/.bashrc
#Setting working directory
WORKDIR /project
