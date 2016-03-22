FROM alpine:latest
MAINTAINER Sven Strack <sven@so36.net>

RUN addgroup -g 500 chuck \
    && adduser -S -D -G chuck -u 500 chuck \
    && mkdir -p /build/docs \
    && chown -R chuck:chuck /build

RUN apk add --no-cache --virtual \
    python \
    python-dev \
    build-base \
    ca-certificates \
    py-pip \
    enchant \
    aspell-en \
    gosu \
    && pip install --upgrade pip \
    && pip install sphinx \
    pyenchant \
    sphinxcontrib-dashbuilder \
    sphinxcontrib.gist \
    sphinx-rtd-theme \
    sphinxcontrib-spelling \
    sphinxcontrib-osexample


WORKDIR /build
VOLUME /build/docs
#USER chuck

COPY conf conf
COPY spelling_wordlist.txt spelling_wordlist.txt
COPY Makefile /build/Makefile
COPY docker-entrypoint.sh /build/entrypoint.sh
#ENTRYPOINT ["/build/entrypoint.sh"]
