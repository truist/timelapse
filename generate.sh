#!/usr/bin/env bash

set -eu

if [[ $# -lt 1 ]]; then
	echo "args: <input_dir> [output_file]" >&2
	exit 1
fi

INPUT_DIR="$1"
shift
if [[ $# -gt 0 ]]; then
	OUTPUT_FILE="$1"
else
	OUTPUT_FILE="timelapse.mp4"
fi

PADDING_LENGTH=6

rm -f "$OUTPUT_FILE"

# https://medium.com/@sekhar.rahul/creating-a-time-lapse-video-on-the-command-line-with-ffmpeg-1a7566caf877
ffmpeg -framerate 25 -pattern_type sequence -i "$INPUT_DIR/%0${PADDING_LENGTH}d.jpg" -c:v libx264 -crf 17 "$OUTPUT_FILE"
# -s:v 1440x1080 -pix_fmt yuv420p

# open "$OUTPUT_FILE"


