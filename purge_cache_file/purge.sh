#!/bin/bash

if [ -z "$1" ]; then
  echo "Usage: $0 <uri>"
  exit 1
fi

CACHE_DIR="/tmp/cache"

URI="http://webserver$1"
MD5=$(echo -n "$URI" | md5sum | awk '{print $1}')

CACHE_FILE=$(find $CACHE_DIR -name "$MD5")


if [ -f "$CACHE_FILE" ]; then
  echo "Purging cache file: $CACHE_FILE"
  rm -f "$CACHE_FILE"
  echo "Cache file purged."
else
  echo "Cache file not found: $CACHE_FILE"
fi
