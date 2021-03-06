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
	curl \
	lua5.2 \
	liblua5.2-dev
RUN pip install numpy scipy

# base torch installation
WORKDIR /home
RUN curl -sk https://raw.githubusercontent.com/torch/ezinstall/master/install-deps | bash
RUN git clone https://github.com/torch/distro
RUN mv distro torch
WORKDIR /home/torch
RUN ./install.sh

# luarocks installation
WORKDIR /home
RUN \
  wget http://luarocks.org/releases/luarocks-2.2.0.tar.gz && \
  tar -xzvf luarocks-2.2.0.tar.gz && \
  rm -f luarocks-2.2.0.tar.gz && \
  cd luarocks-2.2.0 && \
  ./configure && \
  make build && \
  make install && \
  make clean && \
  cd .. && \
  rm -rf luarocks-2.2.0

# extras for torch
RUN luarocks install nn
RUN luarocks install nngraph 
RUN luarocks install image
RUN luarocks install cunn
RUN luarocks install cutorch
RUN luarocks install cunnx
RUN luarocks install cudnn

WORKDIR /home
RUN git clone https://github.com/karpathy/char-rnn
