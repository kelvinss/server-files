#!/bin/bash

source "./conf.env"

if [ -z "$CLOUDFLARE_EMAIL" ]; then
    echo 1>&2 'Missing variable CLOUDFLARE_EMAIL'
    exit 1
fi
if [ -z "$CLOUDFLARE_API_KEY" ]; then
    echo 1>&2 'Missing variable CLOUDFLARE_API_KEY'
    exit 1
fi
if [ -z "$EMAIL" ]; then
    echo 1>&2 'Missing variable EMAIL'
    exit 1
fi
if [ -z "$DOMAIN" ]; then
    echo 1>&2 'Missing variable DOMAIN'
    exit 1
fi

export CLOUDFLARE_EMAIL
export CLOUDFLARE_API_KEY

docker run --rm -it -e CLOUDFLARE_EMAIL -e CLOUDFLARE_API_KEY \
    -v "$(realpath ./lego/):/lego/" \
    goacme/lego \
    --dns cloudflare --email "${EMAIL}" --domains "${DOMAIN}" \
    --path /lego/ run
