#!/bin/bash

if [[ "$1" == "" ]] ; then
  echo "Usage: remove_noise.sh <captured_file.mp4>"
  exit 1
fi

NOISE_REMOVAL_FACTOR=0.21


TMP=/tmp
VIDEO_WITH_NOISE="$1"
AUDIO_WITH_NOISE="$TMP/video-with-noise.wav"
AUDIO_SAMPLE="$TMP/audio-sample.wav"
AUDIO_WITHOUT_NOISE="$TMP/audio-without-noise.wav"
VIDEO_WITHOUT_NOISE="$TMP/video-without-noise.mp4"
NOISE_PROFILE="$TMP/noise.prof"
OLD_VIDEO="${VIDEO_WITH_NOISE%%.*}-original.mp4"
SAMPLE_LENGTH_IN_SECONDS=3
SAMPLE_OFFSET_FROM_END=1
LOG="$TMP/remove-noise-log-$VIDEO_WITH_NOISE.txt"

function die {
  cat "$LOG"
  echo "Error"
  exit 1
}

if [ ! -f "$VIDEO_WITH_NOISE" ] ; then
  echo "Video not found: $VIDEO_WITH_NOISE"
  exit 1
fi

DURATION=$(ffprobe -loglevel error -show_streams "$VIDEO_WITH_NOISE" | grep duration | head -n 1 | cut -f2 -d=)
SAMPLE_START_OFFSET=$((${DURATION%.*} - $SAMPLE_LENGTH_IN_SECONDS - $SAMPLE_OFFSET_FROM_END))
echo "Removing noise: '$VIDEO_WITH_NOISE' ($DURATION seconds)"
rm -rf "$LOG"

echo "- Extract audio track ..."
ffmpeg -y -i "$VIDEO_WITH_NOISE" -ac 1 "$AUDIO_WITH_NOISE" 2>> "$LOG" || die

echo "- Cutting $SAMPLE_LENGTH_IN_SECONDS seconds ..."
ffmpeg -y -i "$VIDEO_WITH_NOISE" -ac 1 -vn -ss $SAMPLE_START_OFFSET -t $SAMPLE_LENGTH_IN_SECONDS "$AUDIO_SAMPLE" 2>> "$LOG" || die

echo "- Generating noise profile ..."
sox "$AUDIO_SAMPLE" -n noiseprof "$NOISE_PROFILE" || die

echo "- Removing noise ..."
sox "$AUDIO_WITH_NOISE" "$AUDIO_WITHOUT_NOISE" noisered  "$NOISE_PROFILE" $NOISE_REMOVAL_FACTOR || die

echo "- Reassembling video ..."
ffmpeg -y -i "$VIDEO_WITH_NOISE" -i "$AUDIO_WITHOUT_NOISE" -map 0:0 -map 1:0 -c:a:a libfaac -ac:a 1 -ar:a 48000 -ab:a 192k -vcodec copy "$VIDEO_WITHOUT_NOISE" 2>> "$LOG" || die

echo "Replacing original file (Backup file: $OLD_VIDEO)..."
mv "$VIDEO_WITH_NOISE" "$OLD_VIDEO"
mv "$VIDEO_WITHOUT_NOISE" "$VIDEO_WITH_NOISE"

echo "Done"


