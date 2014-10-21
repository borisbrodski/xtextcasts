#!/bin/bash

# Ubuntu 12.04 - TOP=52

if [ "$1" == "" ] ; then
  echo "Usage: capture.sh <output_file_name>"
  exit 1
fi

for last; do true; done
FILE=$last

if [[ -f "$FILE" ]]; then
  echo "Backup existing file: $FILE"
  mkdir -p tmp-capture
  mv "$FILE" "tmp-capture/$FILE"
fi

#-f alsa -i pulse -f x11grab -r 24 -s 960x600 -i :0.0+1,100  -vcodec libx264 -preset ultrafast -ab 320k -threads 2  screen.mkv

# 66 - with menu
avconv -f alsa -i pulse -f x11grab -r 24 -s 960x600 -i :0.0+1,52  -vcodec libx264 -preset ultrafast -ab 320k -strict experimental -threads 2 -y $*

# ffmpeg -f alsa -ac 1 -i pulse -acodec pcm_s16le -f x11grab -r 24 -s 960x600 -i :0.0+1,$TOP -vcodec libx264 -vf "format=yuv420p" -profile:v main -preset ultrafast -tune fastdecode -crf 12 -level 3.1 -y $*

# To slow in blender (overlays)
#ffmpeg -f alsa -ac 1 -i pulse -acodec pcm_s16le -f x11grab -r 24 -s 960x600 -i :0.0+1,$TOP -vcodec libx264 -vf "format=yuv420p" -profile:v main -crf 12 -level 3.1 -y $*

# Blender problem
#ffmpeg -f alsa -ac 1 -i pulse -acodec pcm_s16le -f x11grab -r 24 -s 960x600 -i :0.0+1,$TOP -vcodec libx264 -preset slow -crf 15 -y $*

