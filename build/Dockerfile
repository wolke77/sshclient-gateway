
FROM alpine:latest

ENV SSH_PRIVATE_KEY=/sshclient/tunnel_ed25519 \
    SSH_REMOTE_USER=root \
    SSH_REMOTE_HOST="" \
    SSH_REMOTE_PORT=22 \
    TUN_REMOTE_BIND_ADDRESS=127.0.0.1 \
    TUN_REMOTE_BIND_PORT=22022 \
    TUN_TARGET_HOST=localhost \
    TUN_TARGET_PORT=22

ARG UID=101
ARG GID=101

RUN set -x \
    # create sshclient user/group
    && addgroup -g $GID -S sshclient \
    && mkdir -p /home/sshclient \
    && chown $UID:$GID /home/sshclient \
    && adduser -S -D -H -u $UID -h /home/sshclient -s /sbin/nologin -G sshclient -g sshclient sshclient \
    # install packages
    && apk add --no-cache \
        openssh-client \
        ca-certificates \
        git \
        bash

COPY gateway.sh /usr/local/bin/gateway.sh

USER $UID
CMD [ "/usr/local/bin/gateway.sh" ]
