#!/usr/bin/env bash
#
# v1.5.1    2017-11-12    webmaster@highskillz.com
#
set -e
set -o pipefail
set -x
pwd

[ "${ENTRYPOINT_ROOT_DIR}" == "" ] || cd "${ENTRYPOINT_ROOT_DIR}"

# using exec to transfer PID 1 to whatever is executed

case "${MONITORING_TYPE}" in
    "pm2"|"pm2-docker"|"pm2-dev"|"pm2-runtime")
        exec ${MONITORING_TYPE} start --auto-exit ${MONITORING_CLI_ARGS} "$@"
        ;;
    "forever")
        exec forever    start             ${MONITORING_CLI_ARGS} "$@"
        ;;
    "nodemon")
        exec nodemon          --exitcrash ${MONITORING_CLI_ARGS} "$@"
        ;;
esac

# all the previous cases are supposed go their own way...
# in this case, we just ignore the settings and continue

if [ -e /opt/runt/entrypoint-cmd.sh ]; then
    # hook for something else
    exec /opt/runt/entrypoint-cmd.sh "$@"
else
    exec "$@"
fi
