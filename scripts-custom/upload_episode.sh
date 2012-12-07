#!/bin/bash

if [[ "$1" == "--dry-run" ]] ; then
  shift 1
  SCP="echo scp"
else
  SCP=scp
fi

BASE_DIR=$(dirname $(readlink -f $0))
if [ "x$1" == "x" ] ; then
  echo "Provide episode index. For example: $0 001"
  echo "Use '$0 001 -' to skip video upload"
  exit 1
fi

EPISODE_DIR=$(echo $1*)
if [ ! -d "$EPISODE_DIR" ] ; then
  echo "Invalid index. Invalid episode directory '$EPISODE_DIR'"
  exit 1
fi

EPISODE_ZIP="$EPISODE_DIR/$EPISODE_DIR.zip"
EPISODE_STILL="$EPISODE_DIR/$EPISODE_DIR.png"
#if [ ! -f "$EPISODE_STILL" ] ; then
#  echo "Episode still not found: '$EPISODE_STILL'"
#  exit 1
#fi


#NAME=$(echo Homepage/public/assets/episodes/stills/$1*.png | sed 's/.*\/\([^/]*\)\..*/\1/')
#if [ "x$NAME" == "x" ] ; then
#  echo "No episode found"
#  exit 1
#fi

if [ -f "$EPISODE_STILL" ] ; then
  $SCP "$EPISODE_STILL" xtextcasts@xtextcasts.org:xtextcasts/public/assets/episodes/stills/
fi

if [ -f "$EPISODE_ZIP" ] ; then
  $SCP "$EPISODE_ZIP" xtextcasts@xtextcasts.org:xtextcasts/public/assets/episodes/sources/
fi

shift 1

FORMATS=${@-"mp4 ogv webm m4v"}

for ext in $FORMATS ; do
  if [ -f "$EPISODE_DIR/output/output.$ext" ] ; then
    $SCP "$EPISODE_DIR/output/output.$ext" xtextcasts@xtextcasts.org:xtextcasts/public/assets/episodes/videos/$EPISODE_DIR.$ext
  fi
done

#echo "Uploading image $NAME"
#    scp Homepage/public/assets/episodes/stills/$NAME.png xtextcasts@xtextcasts.org:xtextcasts/public/assets/episodes/stills/
#scp Episode/Output/output.ogv xtextcasts@xtextcasts.org:xtextcasts/public/assets/episodes/videos/$NAME.ogv

