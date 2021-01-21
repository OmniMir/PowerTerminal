#Parenting container
FROM debian:testing
#Installing necessary software
RUN apt-get update && apt-get install -y rclone rclone-browser ca-certificates --no-install-recommends && rm -rf /var/lib/apt/lists/*
#Setting workking user
ENV USER=drives
RUN useradd -ms /bin/bash $USER && \
	echo 'PS1="\\[\\033[07;37m\\]\\u@Docker \\w \\$ \\[\\033[00m\\]"' >> /home/$USER/.bashrc
USER $USER
#Setting working directory
WORKDIR /project
