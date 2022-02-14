ARG UBUNTU_VERSION=20.04
ARG MODDABLE_VERSION=OS210826
ARG ESP8266_RTOS_SDK_VERSION=v3.2
ARG ESP8266_ARDUINO_SDK_VERSION=2.3.0

FROM ubuntu:${UBUNTU_VERSION}

########## Moddable ##########

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

########## ESP8266 ##########

RUN apt-get -y install python-is-python3 python3-pip python3-serial

WORKDIR /root/esp

RUN apt install -y curl
RUN curl https://www.moddable.com/private/esp8266.toolchain.linux.tgz | tar zxv

RUN apt install -y unzip
ARG ESP8266_ARDUINO_SDK_VERSION
RUN curl -L https://github.com/esp8266/Arduino/releases/download/2.3.0/esp8266-$ESP8266_ARDUINO_SDK_VERSION.zip >~arduino-sdk.zip
RUN unzip ~arduino-sdk.zip
RUN rm ~arduino-sdk.zip

ARG ESP8266_RTOS_SDK_VERSION
RUN git clone -c advice.detachedHead=false --depth 1 -b $ESP8266_RTOS_SDK_VERSION  https://github.com/espressif/ESP8266_RTOS_SDK.git

WORKDIR /root
COPY start /usr/bin 

