#!/bin/bash

FORMAT=ogv



BASE_DIR=$(dirname $(readlink -f $0))
. $BASE_DIR/encode_base.sh

MP4_TMP_FILE="$TMP_FILE.mp4"
MP4_QT_FASTSTART_TMP_FILE="$TMP_FILE.qt-faststart.mp4"

options="-vcodec libx264 -b:v 1024k -flags +loop+mv4 -cmp 256 \
   -partitions +parti4x4+parti8x8+partp4x4+partp8x8+partb8x8 \
   -me_method hex -subq 7 -trellis 1 -refs 5 -bf 3 \
    -coder 1 -me_range 16 \
         -g 250 -keyint_min 25 -sc_threshold 40 -i_qfactor 0.71 -qmin 10\
   -qmax 51 -qdiff 4"

ffmpeg -y -i "$IN_FILE" -an -pass 1 -threads 2 $options "$MP4_TMP_FILE"

ffmpeg -y -i "$IN_FILE" -acodec libfaac -ar 44100 -ab 96k -ac 1 -pass 2 -threads 2 $options "$MP4_TMP_FILE"

qt-faststart "$MP4_TMP_FILE" "$MP4_QT_FASTSTART_TMP_FILE"
ffmpeg2theora "$MP4_QT_FASTSTART_TMP_FILE" -v 6 -o "$OUT_FILE"



#ffmpeg    -i 0001-4408.avi -an                              -vcodec libtheora -pass 1 -b:v 500k -threads 0 -f ogg  output.ogv
#ffmpeg -y -i 0001-4408.avi -acodec libvorbis -b:a 60k -ac 1 -vcodec libtheora -pass 2 -b:v 500k -threads 0 -f ogg  output.ogv

