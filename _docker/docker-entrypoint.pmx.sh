#!/usr/bin/env bash
#
# v1.7.1    2017-11-13    webmaster@highskillz.com
#
set -e
set -o pipefail
pwd
echo "Entering /docker-entrypoint.sh [pmx] with args [$@]"

exec_via__init() {
    set -x
    exec /usr/bin/dumb-init -- "$@"
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

case "${MONITORING_TYPE}" in
    "pm2"|"pm2-docker"|"pm2-dev"|"pm2-runtime")
        echo "pmx command: [${MONITORING_TYPE}]"
        echo "pmx cli-arg: [${MONITORING_CLI_ARGS}]"
        set -x
        exec ${MONITORING_TYPE} start --auto-exit ${MONITORING_CLI_ARGS} "$@"
        ;;
    "forever")
        echo "pmx command: [${MONITORING_TYPE}]"
        echo "pmx cli-arg: [${MONITORING_CLI_ARGS}]"
        set -x
        exec forever    start             ${MONITORING_CLI_ARGS} "$@"
        ;;
    "nodemon")
        echo "pmx command: [${MONITORING_TYPE}]"
        echo "pmx cli-arg: [${MONITORING_CLI_ARGS}]"
        set -x
        exec nodemon          --exitcrash ${MONITORING_CLI_ARGS} "$@"
        ;;
esac

# all the previous cases are supposed go their own way...
# in this case, we just ignore the settings and continue

# using exec to transfer PID 1 to whatever is executed

# if [ -x /opt/runt/entrypoint-cmd.sh ]; then
#     set -x
#     exec /opt/runt/entrypoint-cmd.sh "$@"
# else
#     set -x
#     exec "$@"
# fi
exec_via__init "$@"
