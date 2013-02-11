#!/bin/bash

#BLENDER_DIR=blender-2.62
BLENDER_DIR=blender-2.65a-linux-glibc211-x86_64
#BLENDER_DIR=blender-2.64-linux-glibc27-x86_64
#BLENDER_DIR=blender-2.64a-linux-glibc27-x86_64

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

BLENDER_FILE="$EPISODE_DIR/$EPISODE_DIR.blend"
if [ ! -f "$BLENDER_FILE" ] ; then
  echo "No blender file found: '$BLENDER_FILE'"
  exit 1
fi

OUT_FILE=$EPISODE_DIR/output/episode-out-of-blender.avi
if [ -f "$OUT_FILE" ] ; then
  mv "$OUT_FILE" "$OUT_FILE.backup"
fi
time bash -c "$BASE_DIR/../../$BLENDER_DIR/blender -b '$BLENDER_FILE' -t 8 -a | grep 'Append frame'"
