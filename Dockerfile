FROM alpine:3.17.2

LABEL name="alpine-oracle" \
      version="1.6" \
      description="Alpine Linux with Oracle Instant Client" \
      homepage="https://github.com/Foxcapades/docker-alpine-oracle"

RUN apk --no-cache add wget unzip libaio libnsl libc6-compat \
    && wget -q https://download.oracle.com/otn_software/linux/instantclient/211000/instantclient-basiclite-linux.x64-21.1.0.0.0.zip \
    && unzip -j instantclient-basiclite-linux.x64-21.1.0.0.0.zip \
       -x instantclient_21_1/ojdbc8.jar \
          instantclient_21_1/ucp.jar \
          instantclient_21_1/xstreams.jar \
       -d /usr/lib \
    && mkdir /jdbc \
    && unzip -j instantclient-basiclite-linux.x64-21.1.0.0.0.zip \
       instantclient_21_1/ojdbc8.jar \
       instantclient_21_1/ucp.jar \
       instantclient_21_1/xstreams.jar -d /jdbc \
    && rm instantclient-basiclite-linux.x64-21.1.0.0.0.zip \
    && ln -s /usr/lib/libnsl.so.2 /usr/lib/libnsl.so.1 \
    && ln -s /lib/libc.so.6 /usr/lib/libresolv.so.2 \
    && ln -s /lib64/ld-linux-x86-64.so.2 /usr/lib/ld-linux-x86-64.so.2 \
    && apk del wget unzip
