#!/usr/bin/env bash
#
# v1.3.1    2017-11-10    webmaster@highskillz.com
#
set -e
set -o pipefail
set -x
pwd

[ "${ENTRYPOINT_ROOT_DIR}" == "" ] || cd "${ENTRYPOINT_ROOT_DIR}"

# using exec to transfer PID 1 to whatever is executed
if [ -e ./entrypoint-cmd.sh ]; then
    # hook for something else
    exec ./entrypoint-cmd.sh "$@"
else
    exec "$@"
fi
