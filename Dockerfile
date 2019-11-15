FROM alpine:3.10.3

MAINTAINER Patrick Pötz <devops@wastebox.biz>

RUN echo "=== INSTALLING SYS DEPS" && \
    apk update && apk add --no-cache \
    python3 git gettext && \
    apk --update add --virtual builddeps python3-dev libffi-dev openssl-dev build-base && \
    \
    echo "=== INSTALLING PIP DEPS" && \
    pip3 install --upgrade pip && \
    pip3 install ansible==2.8.5 botocore boto boto3 && \
    \
    echo "=== Cleanup this mess ===" \
    apk upgrade && \
    apk del builddeps && \
    rm -rf /var/cache/apk/*

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]