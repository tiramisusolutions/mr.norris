FROM alpine:3.3
MAINTAINER Sven Strack <sven@so36.net>

RUN addgroup -g 500 chuck \
    && adduser -S -D -G chuck -u 500 chuck \
    && mkdir -p /build/docs \
    && chown -R chuck:chuck /build

RUN echo http://nl.alpinelinux.org/alpine/edge/testing >> /etc/apk/repositories && \
    apk update && apk add --no-cache \
    python \
    python-dev \
    make \
    gcc \
    py-pip \
    enchant \
    gosu \
    && pip install --upgrade pip \
    && pip install sphinx 


WORKDIR /build
VOLUME /build/docs
#USER chuck

COPY conf conf
COPY spelling_wordlist.txt spelling_wordlist.txt
COPY Makefile /build/Makefile
COPY docker-entrypoint.sh /build/entrypoint.sh
#ENTRYPOINT ["/build/entrypoint.sh"]
