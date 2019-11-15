FROM alpine:3.10.3

MAINTAINER Patrick Pötz <devops@wastebox.biz>

# most of it is stolen from: pad92/docker-ansible-alpine

RUN echo "=== INSTALLING SYS DEPS" && \
    apk update && \
    apk add --no-cache \
        ca-certificates \
        git \
        openssh-client \
        openssl \
        python3 \
        rsync \
        sshpass \
        gettext && \
    apk --update add --virtual \
        builddeps \
        python3-dev \
        libffi-dev \
        openssl-dev \
        build-base && \
    \
    echo "=== INSTALLING PIP DEPS" && \
    pip3 install --upgrade \
        pip \
        cffi && \
    pip3 install \
        ansible==2.8.5 \
        botocore \
        boto \
        boto3 && \
    \
    echo "=== Cleanup this mess ===" \
    apk upgrade && \
    apk del builddeps && \
    rm -rf /var/cache/apk/*

RUN mkdir -p /etc/ansible \
 && echo 'localhost' > /etc/ansible/hosts \
 && echo -e """\
\n\
Host *\n\
    StrictHostKeyChecking no\n\
    UserKnownHostsFile=/dev/null\n\
""" >> /etc/ssh/ssh_config

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]