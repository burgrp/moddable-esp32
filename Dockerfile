ARG UBUNTU_VERSION=20.04
ARG MODDABLE_VERSION=OS210826

FROM ubuntu:${UBUNTU_VERSION}

RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive TZ=Etc/UTC apt-get -y install \
    gcc \
    git \
    wget \
    make \
    libncurses-dev \
    flex \
    bison \
    gperf \
    libgtk-3-dev

WORKDIR /opt
ARG MODDABLE_VERSION
RUN git clone -c advice.detachedHead=false --depth 1 -b $MODDABLE_VERSION https://github.com/Moddable-OpenSource/moddable.git

ENV MODDABLE=/opt/moddable
WORKDIR ${MODDABLE}/build/makefiles/lin
RUN make

ENV PATH=${PATH}:$MODDABLE/build/bin/lin/release

COPY install /usr/bin

RUN useradd build
USER build
