#!/bin/bash

# MAGICs
export WEPLAY_PORT=3001
export WEPLAY_WEB_PORT=3000
export WEPLAY_IO_URL="http://localhost:3001"
export WEPLAY_SERVER_UID=1337
export WEPLAY_IP_THROTTLE=50

echo "DEBUG: giving redis related value"
echo "addr=> ${REDIS_PORT_6379_TCP_ADDR}:${REDIS_PORT_6379_TCP_PORT}"
echo "auth=> ${REDIS_PASSWORD}"

echo "DEBUG hard"
env

if [[ -n "${REDIS_PORT}" ]];then
    export WEPLAY_REDIS_URI=${REDIS_PORT_6379_TCP_ADDR}:${REDIS_PORT_6379_TCP_PORT}
    export WEPLAY_REDIS_AUTH=${REDIS_PASSWORD}
else
    echo "Redis setting not found, can't start server." >&2 && exit 1
fi


forever start index.js
forever start ../weplay-web/index.js

# MAGIC
# tail -f /root/.forever/*.log
