#!/usr/bin/env bash
#
# v1.4.2    2017-11-10    webmaster@highskillz.com
#
set -e
set -o pipefail
set -x
pwd

[ "${ENTRYPOINT_ROOT_DIR}" == "" ] || cd "${ENTRYPOINT_ROOT_DIR}"

# using exec to transfer PID 1 to whatever is executed

[ "${MONITORING_TYPE}" == "pm2" ] && MONITORING_TYPE="pm2-docker"

case "${MONITORING_TYPE}" in
    "pm2-docker")
        exec pm2-docker start --auto-exit "${MONITORING_CLI_ARGS}" "$@"
        ;;
    "forever")
        exec forever    start             "${MONITORING_CLI_ARGS}" "$@"
        ;;
    "nodemon")
        exec nodemon          --exitcrash "${MONITORING_CLI_ARGS}" "$@"
        ;;
    "*")
        if [ -e /opt/runt/entrypoint-cmd.sh ]; then
            # hook for something else
            exec /opt/runt/entrypoint-cmd.sh "$@"
        else
            exec "$@"
        fi
        ;;
esac
