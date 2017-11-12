#!/usr/bin/env bash
#
# v1.5.1    2017-11-12    webmaster@highskillz.com
#
set -e
set -o pipefail
pwd

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

if [ -e /opt/runt/entrypoint-cmd.sh ]; then
    # hook for something else
    set -x
    exec /opt/runt/entrypoint-cmd.sh "$@"
else
    set -x
    exec "$@"
fi
