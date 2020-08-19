#!/bin/bash
# Format target file for Squarespace.
# - Reduce file size to less than 400kb.
# - Ensure image width is less than or equal to 2500 pixels.
#
# Usage:
#   $ for image in <directory>/*; do format-image-for-squarespace.sh "$image"; done
#
# Requires: imagemagick.
#
# https://support.squarespace.com/hc/en-us/articles/206542457-Preventing-visitors-from-downloading-your-images-and-audio
set -e

input="$1"
if ! [ -f "$input" ]; then
  echo "ERROR: input file does not exist '$input'"
  exit 1
fi

# Ensure JPEG.
if [[ $(identify -format "%m" "$input") != "JPEG" ]]; then
  convert "$input" "$input.jpg"
  input="${input}.jpg"
fi

# Resize only if wider than 2500 pixels.
width=$(identify -format "%w" "$input")
resize=""
if ((width > 2500)); then
  # $resize is intentionally unquoted below to allow word splitting.
  resize="-resize 2500"
fi

# Run.
output_directory=~/Desktop/output
mkdir -p "$output_directory"
mogrify \
  -path "$output_directory" \
  -define jpeg:extent=400kb \
  $resize \
  "$input"

echo "Created file: $output_directory/$(basename "$input")"
