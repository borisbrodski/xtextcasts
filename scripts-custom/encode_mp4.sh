#!/bin/bash

FORMAT=mp4


BASE_DIR="$(dirname $(readlink -f $0))"
. $BASE_DIR/encode_base.sh



options="-vcodec libx264 -b:v 265k -flags +loop+mv4 -cmp 256 \
   -partitions +parti4x4+parti8x8+partp4x4+partp8x8+partb8x8 \
   -me_method hex -subq 7 -trellis 1 -refs 5 -bf 3 \
    -coder 1 -me_range 16 \
         -g 250 -keyint_min 25 -sc_threshold 40 -i_qfactor 0.71 -qmin 10\
   -qmax 51 -qdiff 4"

ffmpeg -y -i "$IN_FILE" -an -pass 1 -threads 2 $options "$TMP_FILE"

ffmpeg -y -i "$IN_FILE" -acodec libfaac -ar 44100 -ab 96k -ac 1 -pass 2 -threads 2 $options "$TMP_FILE"

qt-faststart "$TMP_FILE" "$OUT_FILE"







#ffmpeg    -i $1 -vcodec libx264 -vprofile baseline -level 1 -pass 1 -f mp4  output.mp4
#ffmpeg    -i $1 -vcodec libx264 -vprofile baseline -level 1 -pass 2 -f mp4  output.mp4



#-vcodec libx264 -vpre libx264-fast_firstpass -pass 1 -threads 0 -f mp4  output.mp4

#ffmpeg -i 0001-4408.avi -vcodec libx264 -fpre ffpresets_libx264-lossless_max.ffpreset -pass 2 -b:v 285k -threads 0 -f mp4 -tbn 90k -tbc 180k output.mp4
#ffmpeg    -i $1                            -vcodec libx264 -vpre libx264-fast_firstpass -pass 1 -threads 0 -f mp4  output.mp4
#ffmpeg -y -i $1 -acodec ac3 -ac 1 -ab 128k -vcodec libx264 -vpre libx264-fast           -pass 2 -threads 0 -f mp4  output.mp4
#ffmpeg    -i $1 -vcodec libx264 -vprofile baseline -level 1 cabac=0 ref=3 deblock=1:0:0 analyse=0x1:0x111 me=hex subme=7 psy=1 psy_rd=1.00:0.00 mixed_ref=1 me_range=16 chroma_me=1 trellis=1 8x8dct=0 cqm=0 deadzone=21,11 fast_pskip=1 chroma_qp_offset=-2 threads=12 sliced_threads=0 nr=0 decimate=1 interlaced=0 bluray_compat=0 constrained_intra=0 bframes=0 weightp=0 keyint=250 keyint_min=25 scenecut=40 intra_refresh=0 rc_lookahead=40 rc=crf mbtree=1 crf=23.0 qcomp=0.60 qpmin=0 qpmax=69 qpstep=4 ip_ratio=1.40 aq=1:1.00 output.mp4

