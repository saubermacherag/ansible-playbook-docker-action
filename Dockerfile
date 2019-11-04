FROM alpine:3.10.3

RUN apk update && \
    apk add ansible=2.8.4-r0 && \
    apk upgrade

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]