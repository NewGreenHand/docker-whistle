#!/bin/bash
set -e

echo -e "启动容器...\n"

w2 start

echo -e "容器启动成功...\n"

if [ "${1#-}" != "${1}" ] || [ -z "$(command -v "${1}")" ]; then
  set -- node "$@"
fi

exec "$@"