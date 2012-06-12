#!/bin/bash

./encode_mp4.sh "$1"
./encode_ogv.sh "$1"
./encode_webm.sh "$1"
./encode_m4v.sh "$1"

