#!/usr/bin/env bash
#
# v1.7.1    2017-11-13    webmaster@highskillz.com
#
set -e
set -o pipefail
pwd
echo "Entering /docker-entrypoint.sh [nop] with args [$@]"

exec_via__init() {
    set -x
    exec /usr/bin/dumb-init -- exec "$@"
}

# instructions for Azure AppService on Linux from
# https://docs.microsoft.com/en-us/azure/app-service/containers/tutorial-custom-docker-image
set -x
if [ "${AZ__OPENSSH_SERVER__ENABLE}" == "1" ]; then
    if [ -n "${AZ__OPENSSH_SERVER__PASSWD}" ]; then
        # configuring SSH to start
        echo "${AZ__OPENSSH_SERVER__PASSWD}" | chpasswd
        echo "cd $(pwd)" >> /etc/bash.bashrc
        ssh-keygen -A
        /usr/sbin/sshd -f /etc/ssh/sshd_config
    fi
fi

if [ "${ENTRYPOINT_ROOT_DIR}" != "" ]; then
    cd "${ENTRYPOINT_ROOT_DIR}"
    pwd
fi

# using exec to transfer PID 1 to whatever is executed

# if [ -x /opt/runt/entrypoint-cmd.sh ]; then
#     set -x
#     exec /opt/runt/entrypoint-cmd.sh "$@"
# else
#     set -x
#     exec "$@"
# fi
exec_via__init "$@"
