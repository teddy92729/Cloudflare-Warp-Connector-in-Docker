#!/usr/bin/env bash

set -e

if [ ! -f /inited ]; then
    echo >> /inited;
    echo "Initializing Cloudflare Warp...";
    dbus-daemon --system;
    warp-svc > /dev/null & 
    sleep 5;
    if [ -z "$WARP_CONNECTOR_TOKEN" ]; then
        warp-cli --accept-tos registration new > /dev/null;  
    else
        warp-cli --accept-tos connector new $WARP_CONNECTOR_TOKEN > /dev/null;
    fi
    
    warp-cli --accept-tos connect > /dev/null;
fi

bash;