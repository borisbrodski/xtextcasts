#!/bin/bash

# Ubuntu 12.04 - TOP=52

if [ "$TOP" == "" ] ; then
  echo "Set TOP prior to run this script"
  exit 1
fi
if [ "$1" == "" ] ; then
  echo "Usage: capture.sh <output_file_name>"
  exit 1
fi

for last; do true; done
FILE=$last

if [[ -f "$FILE" ]]; then
  echo "Backup existing file: $FILE"
  mv "$FILE" "OLD-$FILE"
fi

ffmpeg -f alsa -ac 1 -i pulse -acodec pcm_s16le -f x11grab -r 24 -s 960x600 -i :0.0+1,$TOP -vcodec libx264 -preset slow -crf 15 -y $*

