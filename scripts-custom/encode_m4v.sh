#!/bin/sh
#ffmpeg    -i 0001-4408.avi                            -vcodec libx264 -vpre libx264-veryslow_firstpass -pass 1 -threads 0 -f m4v -s 640x400 output.m4v
ffmpeg -y -i 0001-4408.avi -acodec aac -ac 1 -ab 98k -vcodec libx264 -vpre libx264-veryslow     -strict experimental      -pass 2 -threads 0 -f m4v -s 640x400 output.m4v
