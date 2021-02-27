#!/usr/bin/env bash
#
# Convert video to gif
#
# Usage:
#
#  gifify -i FILE [OPTIONS]
#
# To the list of all options, use
#
#   gifify --help
#

set -e

POSITIONAL=()
SCALE=1
FPS=24
PTS=1
PALETTE="custom"
COMPRESS=0

while [[ $# -gt 0 ]]
do
  key="$1"

  case $key in
    -i|--input)
      INPUT="$2"
      shift # past argument
      shift # past value
      ;;
    -o|--output)
      OUTPUT="$2"
      shift # past argument
      shift # past value
      ;;
    -s|--scale)
      SCALE="$2"
      shift # past argument
      shift # past value
      ;;
    --fps)
      FPS="$2"
      shift # past argument
      shift # past value
      ;;
    --pts)
      PTS="$2"
      shift # past argument
      shift # past value
      ;;
    --default-palette)
      PALETTE="default"
      shift # past argument
      ;;
    --compress)
      COMPRESS=1
      shift # past argument
      ;;
    *)    # unknown option
      POSITIONAL+=("$1") # save it in an array for later
      shift # past argument
      ;;
  esac
done
set -- "${POSITIONAL[@]}" # restore positional parameters

function print_usage() {
  echo "Usage:

 gifify -i FILE [OPTIONS]

   -i, --input FILE     (required) specify input video file

   -o, --output FILE    (optional) specify output gif file

                        defaults to input file with extension changed to gif

   -s, --scale INT      (optional) specify scale of the resulting gif (affects
                        both width and height)

                        affects speed of conversion and physical size of the
                        resulting gif

                        defaults to 1

   --fps INT            (optional) specify FPS of the resulting gif

                        defaults to 24

   --pts INT            (optional) specify PTS of the resulting gif

                        affects speed of the playback

                        defaults to 1

   --default-palette    (optional) enforce default palette instead of
                        specially generated one, may lead to worse quality

   --compress           (optional) compress the gif to make physical size
                        lesser, may lead to worse quality
"
}

if [[ -z $INPUT ]]; then
  echo "Missing input"
  print_usage
  exit 1
fi

if [[ ! -f $INPUT ]]; then
  echo "'$INPUT' is not a file"
  print_usage
  exit 1
fi

if [[ -z $OUTPUT ]]; then
  OUTPUT="${INPUT%.*}.gif"
fi

if [[ $COMPRESS == "1" ]]; then
  OUTPUT_TEMP="tmp_$OUTPUT"
else
  OUTPUT_TEMP="$OUTPUT"
fi

PALETTE_FILE="${INPUT%.*}.png"
filters="fps=${FPS},scale=iw*${SCALE}:ih*${SCALE}:flags=lanczos,setpts=${PTS}*PTS"

echo "input    = ${INPUT}"
echo "output   = ${OUTPUT}"
echo "scale    = ${SCALE}"
echo "fps      = ${FPS}"
echo "pts      = ${PTS}"
echo "palette  = ${PALETTE}"
echo "compress = ${COMPRESS}"
echo "args     = ${POSITIONAL[*]}"
echo "filters  = $filters"
echo

function cleanup () {
  rm -f "$PALETTE_FILE"
}

trap cleanup INT TERM EXIT

case $PALETTE in
  custom)
    # shellcheck disable=SC2086
    ffmpeg ${POSITIONAL[*]} \
      -i "$INPUT" \
      -vf "$filters,palettegen" \
      "$PALETTE_FILE"

    # shellcheck disable=SC2086
    ffmpeg ${POSITIONAL[*]} \
      -i "$INPUT" \
      -i "$PALETTE_FILE" \
      -filter_complex "$filters [x]; [x][1:v] paletteuse" \
      "$OUTPUT_TEMP"
    ;;

  default)
    # shellcheck disable=SC2086
    ffmpeg ${POSITIONAL[*]} \
      -i "$INPUT" \
      -filter_complex "$filters" \
      "$OUTPUT_TEMP"
    ;;
esac

if [[ $COMPRESS == "1" ]]; then
  gifsicle --optimize=3 --delay=3 "$OUTPUT_TEMP" -o "$OUTPUT"
fi
