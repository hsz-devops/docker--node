#!/usr/bin/env bash
#
# v1.2.0   webmaster@highskillz.com
#
set -e
set -o pipefail
# set -x
# pwd

[ "${ENTRYPOINT_CWD}" == "" ] || cd "${ENTRYPOINT_CWD}"

# using exec to allow command to have PID 1
exec "$@"
