#!/usr/bin/env bash

set -eu

IMPORT_DIR="imported"
RENAMED_DIR="renamed"

# picture_filename %v-%Y%m%d-%H%M%S
# the %v is "event" but that resets whenever the process is restarted,
# so it's stupid that it's first (or even there at all), but it's too late now

find "$IMPORT_DIR" -iname '*.jpg' | sort -t '-' -k 2n -k 3n | cat -n | while read -r n f ; do
	no_event="$(echo $f | sed -E 's/^[^-]+-//')"
	date_part="$(echo $no_event | grep -Eo '^[^-]+')"
	mkdir -p "$RENAMED_DIR/$date_part"
	mv -v "$f" "$RENAMED_DIR/$date_part/$no_event"
done
