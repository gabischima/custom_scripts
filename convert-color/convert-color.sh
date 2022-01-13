#!/bin/sh
# -------------------------------------------------------------
# Authors:
# Gabriela Schirmer Mauricio <gabismauricio@gmail.com>
# -------------------------------------------------------------
#
# sh convert-color.sh --color FFFFFF|#FFFFFF -> (red: 255, green: 255, blue: 255)
# sh convert-color.sh --color FFFFFF|#FFFFFF --base 1 -> (red: 1, green: 1, blue: 1)
# sh convert-color.sh --color FFFFFF|#FFFFFF --base 255 -> (red: 255, green: 255, blue: 255)
# sh convert-color.sh --color FFFFFF|#FFFFFF --to UIColor -> UIColor(red: 1, green: 1, blue: 1, alpha: 1)

# sh convert-color.sh --color UIColor(red: 1, green: 1, blue: 1, alpha: 1) --base 255 -> (red: 255, green: 255, blue: 255)
# sh convert-color.sh --color UIColor(red: 0, green: 0, blue: 0, alpha: 0) --to hex -> #000000


# https://www.color-hex.com/color/

main() {
  PARAMS=""
  COLOR=""

  while (( "$#" )); do
    case "$1" in
      -t|--color)
          COLOR=$2
          shift
        ;;
      -*|--*=)
        # unsupported flags
        MSG_ONE="ERROR:"
        MSG_TWO="This flag does not exist: $1" >&2
        print_message
        exit 1
        ;;
      *) # preserve positional arguments
        PARAMS="$PARAMS $1"
        shift
        ;;
    esac
  done
}

main "$@"