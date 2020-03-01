FROM node:8-alpine
# FROM keymetrics/pm2:8
# # FROM really/node-pm2-git

# https://engineeringblog.yelp.com/2016/01/dumb-init-an-init-for-docker.html

# ----------------------------------------------------------------------------------------
ARG AZ__OPENSSH_SERVER__ENABLE
ENV AZ__OPENSSH_SERVER__ENABLE=${AZ__OPENSSH_SERVER__ENABLE:-0}

ARG AZ__OPENSSH_SERVER__PASSWD
ENV AZ__OPENSSH_SERVER__PASSWD=${AZ__OPENSSH_SERVER__PASSWD:-root:Docker!}

# ----------------------------------------------------------------------------------------
RUN \
    echo "===> Updating TLS certificates..."         && \
    apk --update add \
            ca-certificates \
            openssl \
    && \
    \
    echo "===> Adding usefull packages for devops shell-works..."  && \
    apk --update add \
            dumb-init \
            coreutils \
            file \
            bash \
            less \
            nano \
            \
            curl \
            wget \
            \
            git \
            make \
    \
    && \
    yarn global add \
        pm2 \
        nodemon \
        forever \
    \
    && \
    echo "===> Checking versions..."  && \
    node --version && \
    npm --version  && \
    yarn --version && \
    git --version  && \
    \
    pm2     --version && \
    nodemon --version && \
    forever --version && \
    \
    git --version && \
    \
    echo "===> OpenSSH Setup..."  && \
        apk --update add \
        openssh \
        tcptraceroute \
    && \
    \
    echo "cd ~" >> /etc/bash.bashrc && \
    \
    echo "===> Cleaning up ..."  && \
    yarn cache clean && \
    \
    rm -rf \
      "${HOME}/.cache"  \
      "${HOME}/.config" \
      "${HOME}/.pm2"    \
      /var/cache/apk/*  \
      /tmp/*            \
      /var/tmp/*        \
    && \
    \
    echo "OK!"

SHELL ["/bin/bash", "-c"]

# ----------------------------------------------------------------------------------------
COPY ./_docker/docker-entrypoint.pmx.sh  /docker-entrypoint.sh
RUN  chmod -R a+xX                       /docker-entrypoint.sh

COPY ./_root/etc/ssh/sshd_config         /etc/ssh/

ARG MONITORING_TYPE
ENV MONITORING_TYPE=${MONITORING_TYPE}

ARG MONITORING_CLI_ARGS
ENV MONITORING_CLI_ARGS=${MONITORING_CLI_ARGS}

# # ----------------------------------------------------------------------------------------
# RUN \
#      groupadd -r nodejs \
#   && useradd -m -r -g nodejs nodejs
#
# USER nodejs
#
# ----------------------------------------------------------------------------------------
RUN mkdir -p /opt/app /opt/log /opt/data
WORKDIR      /opt/app

EXPOSE 2222 8000
ENTRYPOINT [ "/docker-entrypoint.sh" ]
CMD        [ "pm2-docker", "start", "--auto-exit", "--env", "production", "process.yml" ]
