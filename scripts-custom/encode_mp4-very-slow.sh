#!/bin/sh
#ffmpeg -i 0001-4408.avi -vcodec libx264 -fpre ffpresets_libx264-lossless_max.ffpreset -pass 2 -b:v 285k -threads 0 -f mp4 -tbn 90k -tbc 180k output.mp4



ffmpeg    -i $1                            -vcodec libx264 -vpre libx264-veryslow_firstpass -pass 1 -threads 0 -f mp4  output.mp4
ffmpeg -y -i $1 -acodec ac3 -ac 1 -ab 128k -vcodec libx264 -vpre libx264-veryslow           -pass 2 -threads 0 -f mp4  output.mp4
