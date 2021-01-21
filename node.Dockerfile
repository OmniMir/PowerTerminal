#Parenting container
FROM debian:testing
#Installing necessary software
RUN apt-get update && apt-get install -y --no-install-recommends \
		nodejs \
		npm \
	&& rm -rf /var/lib/apt/lists/*
#Get Registry for NPM
RUN npm config set registry http://registry.npmjs.org/
#Setting workking user
ENV USER=node
RUN useradd $USER -ms /bin/bash && \
	echo 'PS1="\\[\\033[07;37m\\]\\u@Docker \\w \\$ \\[\\033[00m\\]"' >> /home/$USER/.bashrc
USER $USER
#Setting working directory
WORKDIR /project
