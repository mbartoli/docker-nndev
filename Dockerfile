#version 0.0.1
FROM ubuntu:14.04
MAINTAINER Mike Bartoli "michael.bartoli@pomona.edu"
RUN apt-get update
RUN apt-get -y install \
	python \
	build-essential \
	python-dev \
	python-pip \
	wget \
	unzip \
	ipython \
	git \
	perl \
	libatlas-base-dev \
	gcc \
	gfortran \
	g++ \ 
	curl
RUN pip install numpy scipy

# torch installation
WORKDIR /home
RUN curl -sk https://raw.githubusercontent.com/torch/ezinstall/master/install-deps | bash
RUN git clone https://github.com/torch/distro
RUN mv distro torch
WORKDIR /home/torch
RUN ./install.sh




