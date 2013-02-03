#!/bin/bash
ffmpeg -f alsa -ac 2 -i pulse -acodec pcm_s16le -f x11grab -r 24 -s 960x600 -i :0.0+1,52 -vcodec libx264 -preset ultrafast -qp 0 -threads 0 SCREENCAST.mkv
