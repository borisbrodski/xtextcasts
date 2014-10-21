#!/bin/bash

FORMAT=webm



BASE_DIR=$(dirname $(readlink -f $0))
. $BASE_DIR/encode_base.sh


avconv -y -i "$IN_FILE" -an                              -vcodec libvpx -pass 1 -b:v 140k -threads 0 -f webm  "$OUT_FILE"
avconv -y -i "$IN_FILE" -acodec libvorbis -b:a 60k -ac 1 -vcodec libvpx -pass 2 -b:v 140k -threads 0 -f webm  "$OUT_FILE"
