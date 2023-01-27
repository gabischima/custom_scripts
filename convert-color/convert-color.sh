#!/bin/sh
# -------------------------------------------------------------
# Authors:
# Gabriela Schirmer Mauricio <gabismauricio@gmail.com>
# -------------------------------------------------------------
# Color converter: Hex to RGB

print_usage() {
  echo "\

sh convert-color.sh [-c|--color] 000000 [-a|-alpha] [-o|--opacity] [--base1]

Convert HEX color to RGB
-----------------------------------------------------------
-c | --color         Pass color value in HEX
-1 | --base1         RGB numbers on base 1
-a | --alpha         Display RGB with alpha value
-o | --opacity       Display RGB with opacity value
-h | --help          Print usage
-----------------------------------------------------------
"
}

# $((a / b))
TITLE=""
SUBTITLE=""

COLOR=""
OPACITY=false
ALPHA=false
BASE_ONE=false

print_message() {
  echo "---------------------------------------------"
  echo "$TITLE\n$SUBTITLE"
  echo "---------------------------------------------"
  TITLE=""
  SUBTITLE=""
}

convert_color() {
  if [ ${COLOR:0:1} = "#" ]
  then
    COLOR="${COLOR:1}"
  fi

  RED=$(printf "%d" 0x${COLOR:0:2})
  GREEN=$(printf "%d" 0x${COLOR:2:2})
  BLUE=$(printf "%d" 0x${COLOR:4:2})

  if [ $BASE_ONE = true ]
  then
    RED=$(awk -v n="$RED" 'BEGIN{printf "%.2f\n", n/255}')
    GREEN=$(awk -v n="$GREEN" 'BEGIN{printf "%.2f\n", n/255}')
    BLUE=$(awk -v n="$BLUE" 'BEGIN{printf "%.2f\n", n/255}')
  fi

  SUBTITLE="(red: $RED, green: $GREEN, blue: $BLUE"

  if [ $ALPHA = true ]
  then
    TITLE="rgba color"
    SUBTITLE="${SUBTITLE}, alpha: 1.0)"
  else
    if [ $OPACITY = true ]
    then
      TITLE="rgbo color"
      SUBTITLE="${SUBTITLE}, opacity: 1.0)"
    else
      TITLE="rgb color"
      SUBTITLE="${SUBTITLE})"
    fi
  fi
  print_message
}

main() {
  PARAMS=""

  while (( "$#" )); do
    case "$1" in
      -c|--color)
          COLOR=$2
          shift
        ;;
      -a|--alpha)
          ALPHA=true
          shift
        ;;
      -o|--opacity)
          OPACITY=true
          shift
        ;;
      -1|--base1)
          BASE_ONE=true
          shift
        ;;
      -h|--help)
        print_usage
        exit 0
        ;;
      -*|--*=)
        # unsupported flags
        TITLE="ERROR"
        SUBTITLE="Flag does not exist: $1" >&2
        print_message
        exit 1
        ;;
      *) # preserve positional arguments
        PARAMS="$PARAMS $1"
        shift
        ;;
    esac
  done
  convert_color
}

main "$@"