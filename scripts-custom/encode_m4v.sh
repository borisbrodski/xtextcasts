#!/bin/bash


FORMAT=m4v


BASE_DIR="$(dirname $(readlink -f $0))"
. $BASE_DIR/encode_base.sh


avconv -y -i "$IN_FILE"       -vcodec libx264 -strict experimental -b:v 117k -threads 0 -pass 1 "$OUT_FILE"
avconv -y -i "$IN_FILE" -ac 1 -vcodec libx264 -strict experimental -b:v 117k -threads 0 -pass 2 "$OUT_FILE"


#ffmpeg    -i 0001-4408.avi                            -vcodec libx264 -vpre libx264-veryslow_firstpass -pass 1 -threads 0 -f m4v -s 640x400 output.m4v
#ffmpeg -y -i "$IN_FILE" -acodec aac -ac 1 -ab 98k -vcodec libx264 -vpre libx264-veryslow     -strict experimental      -pass 2 -threads 0 -f m4v -s 640x400 output.m4v

