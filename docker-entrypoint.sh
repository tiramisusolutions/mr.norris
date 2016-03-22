#!/bin/sh

set -e
# allow the container to be started with `--user`
if [ "$1" = 'make' ]; then
    chown -R chuck .
    exec gosu chuck "$@"
fi

exec "$@"
