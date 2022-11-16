FROM ghcr.io/linuxserver/baseimage-alpine-nginx:3.16

# set version label
ARG HEIMDALL_RELEASE
LABEL maintainer="loeken"

RUN \
 echo "**** install runtime packages ****" && \
 apk add --no-cache --upgrade \
	curl \
	php81-ctype \
	php81-curl \
	php81-pdo_pgsql \
	php81-pdo_sqlite \
	php81-pdo_mysql \
	php81-tokenizer \
	php81-zip && \
 echo "**** install heimdall ****" && \
 mkdir -p \
	/heimdall && \
 if [ -z ${HEIMDALL_RELEASE+x} ]; then \
	HEIMDALL_RELEASE=$(curl -sX GET "https://api.github.com/repos/linuxserver/Heimdall/releases/latest" \
	| awk '/tag_name/{print $4;exit}' FS='[""]'); \
 fi && \
 curl -o \
 /heimdall/heimdall.tar.gz -L \
	"https://github.com/linuxserver/Heimdall/archive/${HEIMDALL_RELEASE}.tar.gz" && \
 echo "**** cleanup ****" && \
 rm -rf \
	/tmp/*

