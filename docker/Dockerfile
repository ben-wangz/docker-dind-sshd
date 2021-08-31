ARG DOCKER_BUILDX_VERSION=0.6.1
ARG DIND_VERSION=20.10.7-dind

FROM docker/buildx-bin:${DOCKER_BUILDX_VERSION} as builder

FROM docker:${DIND_VERSION}
# cannot use ARG variables in --from
COPY --from=builder /buildx /usr/libexec/docker/cli-plugins/docker-buildx
ARG ALPINE_REPO=dl-cdn.alpinelinux.org

# sshd need to initialize/change root password
RUN set -x \
    && sed -i "s/dl-cdn.alpinelinux.org/${ALPINE_REPO}/g" /etc/apk/repositories \
    && apk add --update --no-cache openssh-server bash curl \
    && rm -rf $HOME/.cache \
    && chmod a+x /usr/local/bin/dind \
    && mkdir -p $HOME/.ssh \
    && chmod 700 $HOME/.ssh \
    && touch $HOME/.ssh/authorized_keys \
    && chmod 600 $HOME/.ssh/authorized_keys \
    && sed -i "s#/bin/ash#/bin/bash#g" /etc/passwd \
    && rm -rf /etc/ssh/ssh_host_rsa_key /etc/ssh/ssh_host_dsa_key \
    && echo "PermitRootLogin prohibit-password" >> /etc/ssh/sshd_config \
    && echo "PasswordAuthentication no" >> /etc/ssh/sshd_config \
    && passwd -u root

COPY run.sh /run.sh
RUN chmod +x /run.sh

ENTRYPOINT ["/run.sh"]
CMD []

HEALTHCHECK --interval=10s --timeout=3s CMD docker info --format '{{json .ServerVersion}}'
