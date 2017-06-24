## Pull base image.
FROM ubuntu:16.04

MAINTAINER Ivan Subotic <ivan.subotic@unibas.ch>

# Silence debconf messages
RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections

# Install.
RUN \
  sed -i 's/# \(.*multiverse$\)/\1/g' /etc/apt/sources.list && \
  apt-get -qq update && \
  apt-get install -y build-essential software-properties-common && \
  add-apt-repository -y ppa:ubuntu-toolchain-r/test && \
  apt-get -qq update && apt-get -y install \
  cmake \
  g++-6 \
  libtbb-dev \
  libace-dev \
  libssl-dev \
  libmysqlclient-dev && \
  update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-6 90 && \
  rm -rf /var/lib/apt/lists/*

RUN g++   --version
RUN g++-6 --version

ENV TBB_ROOT_DIR=/usr/include/tbb/
ENV ACE_ROOT=/usr/include/ace/