#!/usr/bin/env bash

set -eu

SOURCE="timelapse:/var/lib/motion/"
IMPORT_DIR="imported"

rsync -rvz "$SOURCE" "$IMPORT_DIR/"
