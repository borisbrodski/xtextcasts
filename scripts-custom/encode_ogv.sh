#!/bin/sh
#ffmpeg    -i 0001-4408.avi -an                              -vcodec libtheora -pass 1 -b:v 500k -threads 0 -f ogg  output.ogv
#ffmpeg -y -i 0001-4408.avi -acodec libvorbis -b:a 60k -ac 1 -vcodec libtheora -pass 2 -b:v 500k -threads 0 -f ogg  output.ogv

infile="$1"
tmpfile="output_tmp-ogv.mp4"
outfile="output-ogv.mp4"
options="-vcodec libx264 -b:v 512k -flags +loop+mv4 -cmp 256 \
   -partitions +parti4x4+parti8x8+partp4x4+partp8x8+partb8x8 \
   -me_method hex -subq 7 -trellis 1 -refs 5 -bf 3 \
    -coder 1 -me_range 16 \
         -g 250 -keyint_min 25 -sc_threshold 40 -i_qfactor 0.71 -qmin 10\
   -qmax 51 -qdiff 4"

ffmpeg -y -i "$infile" -an -pass 1 -threads 2 $options "$tmpfile"

ffmpeg -y -i "$infile" -acodec libfaac -ar 44100 -ab 96k -ac 1 -pass 2 -threads 2 $options "$tmpfile"

qt-faststart "$tmpfile" "$outfile"
ffmpeg2theora $outfile -o output.ogv
