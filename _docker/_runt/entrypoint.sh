#!/usr/bin/env bash
#
# v1.2.1   webmaster@highskillz.com
#
set -e
set -o pipefail
set -x
pwd

[ "${ENTRYPOINT_ROOT_DIR}" == "" ] || cd "${ENTRYPOINT_ROOT_DIR}"

# using exec to transfer PID 1 to whatever is executed
exec "$@"
