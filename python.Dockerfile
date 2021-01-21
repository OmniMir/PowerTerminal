#Parenting container
FROM debian:testing
#Installing necessary software
RUN apt-get update && apt-get install -y --no-install-recommends \
		python3 \
		pypy3 \
	&& rm -rf /var/lib/apt/lists/*
#Setting workking user
ENV USER=python
RUN useradd -ms /bin/bash $USER && \
	echo 'PS1="\\[\\033[07;37m\\]\\u@Docker \\w \\$ \\[\\033[00m\\]"' >> /home/$USER/.bashrc
USER $USER
#Setting working directory
WORKDIR /project
