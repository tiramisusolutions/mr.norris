FROM alpine:3.3
MAINTAINER Sven Strack <sven@so36.net>

RUN addgroup -g 500 chuck \
    && adduser -S -D -G chuck -u 1000 chuck \
    && mkdir -p /build/docs \
    && chown -R chuck:chuck /build

RUN echo http://nl.alpinelinux.org/alpine/edge/testing >> /etc/apk/repositories && \
    apk update && apk add --no-cache \
    python \
    python-dev \
    build-base \
    py-pip \
    enchant \
    gosu \
    ca-certificates \
    && pip install --upgrade pip \
    && pip install sphinx \
    pyenchant \
    sphinxcontrib-dashbuilder \
    sphinxcontrib.gist \
    sphinx-rtd-theme \
    sphinxcontrib-spelling \
    sphinxcontrib-osexample \
    && rm -rf /var/cache/apk/* \


#VOLUME /build/docs
#USER chuck
#WORKDIR /build
COPY conf /build/conf
COPY spelling_wordlist.txt /build/spelling_wordlist.txt
COPY Makefile /build/Makefile
#RUN chown -R chuck:chuck /build
COPY docker-entrypoint.sh /build/entrypoint.sh
ENTRYPOINT ["ash"]
#ENTRYPOINT ["make"]
#ENTRYPOINT ["/build/entrypoint.sh"]
