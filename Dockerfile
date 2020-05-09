FROM alpine:20200428

LABEL name="alpine-oracle" \
      version="1.0" \
      description="Alpine Linux with Oracle Instant Client" \
      homepage="https://github.com/Foxcapades/docker-alpine-oracle"

RUN apk --no-cache add wget unzip libaio libnsl libc6-compat

RUN wget -q https://download.oracle.com/otn_software/linux/instantclient/19600/instantclient-basiclite-linux.x64-19.6.0.0.0dbru.zip \
    && unzip -j instantclient-basiclite-linux.x64-19.6.0.0.0dbru.zip \
       -x instantclient_19_6/ojdbc8.jar \
          instantclient_19_6/ucp.jar \
          instantclient_19_6/xstreams.jar \
       -d /usr/lib \
    && mkdir /jdbc \
    && unzip -j instantclient-basiclite-linux.x64-19.6.0.0.0dbru.zip \
       instantclient_19_6/ojdbc8.jar \
       instantclient_19_6/ucp.jar \
       instantclient_19_6/xstreams.jar -d /jdbc \
    && rm instantclient-basiclite-linux.x64-19.6.0.0.0dbru.zip

RUN apk del wget unzip

WORKDIR /lib
RUN ln -s libnsl.so.2 /usr/lib/libnsl.so.1 \
    && ln -s libc.so.6 /usr/lib/libresolv.so.2

WORKDIR /

