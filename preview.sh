#!/usr/bin/env bash

set -eu

RENAMED_DIR="renamed"
SCRIPT_DIR="$(pwd)"

cd "$RENAMED_DIR"

for datedir in * ; do
	"$SCRIPT_DIR/renumber.sh" "$datedir" "$datedir.renumbered"
	"$SCRIPT_DIR/generate.sh" "$datedir.renumbered" "$datedir.mp4"
	rm -r "$datedir.renumbered"
done

echo "Done!"
