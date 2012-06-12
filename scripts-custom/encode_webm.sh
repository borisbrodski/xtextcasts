#!/bin/sh
ffmpeg    -i 0001-4408.avi -an                              -vcodec libvpx -pass 1 -b:v 140k -threads 0 -f webm  output.webm
ffmpeg -y -i 0001-4408.avi -acodec libvorbis -b:a 60k -ac 1 -vcodec libvpx -pass 2 -b:v 140k -threads 0 -f webm  output.webm
