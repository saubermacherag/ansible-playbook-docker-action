FROM saubermacherag/docker-ansible-alpine/ansible-alpine:2.8.5-3.10.3

MAINTAINER Patrick Pötz <devops@wastebox.biz>

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]