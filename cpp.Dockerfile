#Parenting container
FROM debian:testing
#Installing necessary software
RUN apt-get update && apt-get install -y --no-install-recommends \
		gcc \
		gdb \
	&& rm -rf /var/lib/apt/lists/*
#Setting workking user
ENV USER=cpp
RUN useradd -ms /bin/bash $USER && \
	echo 'PS1="\\[\\033[07;37m\\]\\u@Docker \\w \\$ \\[\\033[00m\\]"' >> /home/$USER/.bashrc
USER $USER
#Setting working directory
WORKDIR /project
