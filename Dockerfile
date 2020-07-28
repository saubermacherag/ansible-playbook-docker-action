FROM pinkrobin/docker-ansible-alpine:2.9.11

MAINTAINER Patrick Pötz <devops@wastebox.biz>

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]