#!/usr/bin/env bash

set -eu

IMAGE_DIR="images"
ORDERED_DIR="images_ordered"
PADDING_LENGTH=6
OUTPUT_FILE="timelapse.mp4"
SCP_SOURCE="timelapse:/var/lib/motion/*.jpg"


if [[ $# == 1 ]] && [[ "--fetch" == "$1" ]]; then
	echo "Downloading files..."
	scp "$SCP_SOURCE" "$IMAGE_DIR/"
else
	echo "NOT downloading files (use --fetch to do so)"
fi


# picture_filename %v-%Y%m%d-%H%M%S
# the %v is "event" but that resets whenever the process is restarted,
# so it's stupid that it's first (or even there at all), but it's too late now

echo "Generating ordered filenames..."
rm -rf "$ORDERED_DIR"
mkdir "$ORDERED_DIR"

find "$IMAGE_DIR" -iname '*.jpg' | sort -t '-' -k 2n -k 3n | cat -n | while read -r n f ; do
	ln -s "../$f" "$ORDERED_DIR/$(printf "%0${PADDING_LENGTH}d.jpg" "$n")"
done


echo "Generating video..."
rm -f "$OUTPUT_FILE"

# https://medium.com/@sekhar.rahul/creating-a-time-lapse-video-on-the-command-line-with-ffmpeg-1a7566caf877
ffmpeg -framerate 30 -pattern_type sequence -i "images_ordered/%0${PADDING_LENGTH}d.jpg" -c:v libx264 -crf 17 "$OUTPUT_FILE"
# -s:v 1440x1080 -pix_fmt yuv420p


echo "Done!"

open "$OUTPUT_FILE"

