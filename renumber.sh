#!/usr/bin/env bash

set -eu

if [[ $# -ne 2 ]]; then
	echo "args: <input_dir> <output_dir>" >&2
	exit 1
fi

INPUT_DIR="$1"
OUTPUT_DIR="$2"

PADDING_LENGTH=6


# we expect filenames that are naturally in sorted order

rm -rf "$OUTPUT_DIR"
mkdir "$OUTPUT_DIR"

find "$INPUT_DIR" -iname '*.jpg' | sort -n | cat -n | while read -r n f ; do
	new_name="$(printf "%0${PADDING_LENGTH}d.jpg" "$n")"
	ln -sv "../$f" "$OUTPUT_DIR/$new_name"
	# cp -v "$f" "$OUTPUT_DIR/$new_name"
done

