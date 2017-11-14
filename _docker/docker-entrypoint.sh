#!/usr/bin/env bash
#
# v1.4.2    2017-11-10    webmaster@highskillz.com
#
set -e
set -o pipefail
pwd

if [ "${ENTRYPOINT_ROOT_DIR}" != "" ]; then
    cd "${ENTRYPOINT_ROOT_DIR}"
    pwd
fi

# using exec to transfer PID 1 to whatever is executed
if [ -x /opt/runt/entrypoint-cmd.sh ]; then
    # hook for something else
    set -x
    exec /opt/runt/entrypoint-cmd.sh "$@"
else
    set -x
    exec "$@"
fi
