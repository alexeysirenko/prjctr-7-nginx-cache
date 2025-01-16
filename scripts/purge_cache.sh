#!/bin/bash

CACHE_DIR="/var/cache/nginx"
URI=$1

# Compute the MD5 hash of the cache key
CACHE_KEY=$(echo -n "$URI" | md5sum | awk '{print $1}')

# Construct the cache file path
CACHE_PATH="${CACHE_DIR}/${CACHE_KEY: -2}/${CACHE_KEY: -4:2}/${CACHE_KEY}"

# Check if the cache file exists and remove it
if [ -f "$CACHE_PATH" ]; then
    rm "$CACHE_PATH"
    echo "Cache file removed: $CACHE_PATH"
    exit 0
else
    echo "Cache file not found: $CACHE_PATH"
    exit 1
fi
