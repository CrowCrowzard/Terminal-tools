#!/bin/sh

# Need URL
if [ $# -ne 1 ]; then
  echo "Need [URL]"
  echo "$0 [https://www.google.co.jp]"
  exit 1
fi

wget --spider -r $1
