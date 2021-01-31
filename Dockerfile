FROM node:alpine3.12

LABEL maintainer="whistle Docker Maintainers kenfei@aliyun.com"

ENV PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin \
    LANG=zh_CN.UTF-8 \
    SHELL=/bin/bash \
    PROXY_DIR=/whistle

COPY ./docker-entrypoint.sh ${PROXY_DIR}/docker-entrypoint.sh

RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories \
    && apk update -f \
    && apk upgrade \
    && apk --no-cache add -f bash \
                             coreutils \
                             moreutils \
                             git \
                             wget \
                             curl \
                             nano \
                             tzdata \
                             perl \
                             openssl \
    && rm -rf /var/cache/apk/* \
    && npm install -g whistle --registry=https://registry.npm.taobao.org \
    && cp -f ${PROXY_DIR}/docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh \
    && chmod 777 /usr/local/bin/docker-entrypoint.sh

EXPOSE 8899

ENTRYPOINT docker-entrypoint.sh