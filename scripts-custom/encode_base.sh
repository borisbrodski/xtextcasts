#!/bin/bash

BASE_DIR=$(dirname $(readlink -f $0))
if [ "x$1" == "x" ] ; then
  echo "Provide episode index. For example: $0 001"
  exit 1
fi

EPISODE_DIR=$(echo $1*)
if [ ! -d "$EPISODE_DIR" ] ; then
  echo "Invalid index. Invalid episode directory '$EPISODE_DIR'"
  exit 1
fi

IN_FILE=$EPISODE_DIR/output/episode-out-of-blender.avi

if [ ! -f "$IN_FILE" ] ; then
  echo "Video from blender not found: '$IN_FILE'"
  exit 1
fi

TMP_FILE=$EPISODE_DIR/output/output-tmp.$FORMAT
OUT_FILE=$EPISODE_DIR/output/output.$FORMAT

echo "--------------------"
echo "Encoding format: $FORMAT"
echo "In: $IN_FILE"
echo "Out: $OUT_FILE"
echo "--------------------"

