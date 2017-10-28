#!/bin/bash

set -e

if [ ! -f /etc/exim4/ssl/dhparam.pem ]; then
    /usr/bin/openssl dhparam -out /etc/exim4/ssl/dhparam.pem 2048
fi

/usr/sbin/exim4 -bd -q30m -oP /dev/null -v -C /etc/exim4/exim4.conf &
PID=$!

trap "echo 'Stopping PID $PID'; kill -SIGTERM $PID" SIGINT SIGTERM
while kill -0 $PID > /dev/null 2>&1; do
    wait
done

