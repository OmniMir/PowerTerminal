#Parenting container
FROM debian:testing
#Installing necessary software
RUN apt-get update && \
	apt-get install -y --no-install-recommends \
		git \
		ca-certificates \
	&& rm -rf /var/lib/apt/lists/*
COPY gh.deb /root/gh.deb
RUN apt-get install -y /root/gh.deb && rm -rf /root/gh.deb
#Set github certificate workaround
COPY github-com.pem /root/github-com.pem
RUN cat /root/github-com.pem | tee -a /etc/ssl/certs/ca-certificates.crt
#Setting workking user
ENV USER=git
RUN useradd $USER -ms /bin/bash && \
	echo 'PS1="\\[\\033[07;37m\\]\\u@Docker \\w \\$ \\[\\033[00m\\]"' >> /home/$USER/.bashrc
USER $USER
#Setting working directory
WORKDIR /project
