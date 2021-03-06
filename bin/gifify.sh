#!/usr/bin/env bash
set -euo pipefail

function print_usage() {
  echo "Usage:

  gifify -i FILE [OPTIONS]

    -i, --input FILE     (required) specify input video file

    -o, --output FILE    (optional) specify output gif file

                         defaults to input file with extension changed to gif

    -w, --width INT      (optional) specify width of the resulting gif

                         affects size of resulting gif

    --fps INT            (optional) specify FPS of the resulting gif

                         affects size of resulting gif

                         defaults to 24

    --pts INT            (optional) specify PTS of the resulting gif

                         affects speed of the playback

                         use 0.5 to speed up 2x

                         defaults to 1

  ffmpeg arguments are all supported, including:

    -t duration          record or transcode \"duration\" seconds of audio/video

    -ss time_off         set the start time offset

"
}

INPUT=""
OUTPUT=""
WIDTH=""
FPS=24
PTS=1

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
    -w|--width)
      WIDTH="$2"
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
    -h|--help)    # unknown option
      print_usage
      exit
      ;;
    *)    # unknown option
      POSITIONAL+=("$1") # save it in an array for later                                                                                                       │   80 set -- "${POSITIONAL[@]}" # restore positional parameters
      shift # past argument
      ;;
  esac
done
set -- "${POSITIONAL[@]}" # restore positional parameters

if [[ -z $INPUT ]]; then
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

filters="[0:v]"
filters="$filters fps=$FPS"
[ -n "$WIDTH" ] && filters="$filters,scale=w=$WIDTH:h=-1"
filters="$filters,setpts=$PTS*PTS"
filters="$filters,split [a][b];[a] palettegen=stats_mode=single [p];[b][p] paletteuse=new=1"

set -x
ffmpeg \
  ${POSITIONAL[*]} \
  -i "$INPUT" \
  -filter_complex "$filters" \
  "$OUTPUT" "$@"
