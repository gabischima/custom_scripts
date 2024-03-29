#!/bin/sh
# -------------------------------------------------------------
# Authors:
# Gabriela Schirmer Mauricio <gabismauricio@gmail.com>
# -------------------------------------------------------------
# git-prerelease - automation for alpha, beta, pre-release tags
#

MSG_ONE=""
MSG_TWO=""

print_usage() {
  echo "\

git pre-release [-t] [-m] [-i] [-h]

Create tag for prerelease
-----------------------------------------------------------
-t | --type          Type of pre-release: alpha, beta or rc
-m | --message       Message for the tag
-i | --iterate       Iterate previous tag
-h | --help          Print usage
-----------------------------------------------------------
"
}

print_message() {
  echo ""
  echo "---------------------------------------------"
  echo "$MSG_ONE"
  echo "$MSG_TWO"
  echo "---------------------------------------------"
  MSG_ONE=""
  MSG_TWO=""
}

create_tag() {
  git tag -a "$NEW_VERSION" -m "$MESSAGE"
  TAG=`git for-each-ref --count=1 --sort=-taggerdate --format '%(tag)' refs/tags/v$VERSION_NUMBER* --merged`
  if [ "$TAG" == "$NEW_VERSION" ] ; then
    MSG_ONE="Success!"
    MSG_TWO="New tag created: $TAG"
    print_message
  fi
  echo ""
  # TESTAR
  if [ $PUSH = true ] ; then
    git push origin "$NEW_VERSION"
  fi
}

select_tag_type() {
  echo ""
  echo "Select the tag type"
  select SELECT in alpha beta rc
  do
    case $SELECT in
        "alpha"|"beta"|"rc")
          NEW_VERSION="v$VERSION_NUMBER-$SELECT+1"
          create_tag
          break
          ;;
        *)
          echo "ERROR: Invalid selection. Select 1..3"
        ;;
    esac
  done
}

iterate_tag() {
  IFS="+"
  read -ra SPLIT_IFS <<< "$LATEST_TAG"
  NEXT=$(( ${SPLIT_IFS[1]} + 1 ))
  NEW_VERSION="${SPLIT_IFS[0]}+$NEXT"
}

confirm_iterate() {
  while true; do
    echo ""
    read -p "Iterate this tag? [y|n] " yn
    case $yn in
      [Yy]* )
        iterate_tag
        create_tag
        break
        ;;
      [Nn]* )
        # ASK TAG NAME
        select_tag_type
        break
        ;;
      * )
        echo "Please answer y or no."
        ;;
    esac
  done
}

confirm() {
  NEW_VERSION="v$VERSION_NUMBER-$TYPE+1"
  while true; do
    echo ""
    read -p "Create tag '$NEW_VERSION'? [y|n] " yn
    case $yn in
      [Yy]* )
        create_tag
        break
        ;;
      [Nn]* )
        exit 0
        break
        ;;
      * )
        echo "Please answer y or n."
        ;;
    esac
  done
}

get_latest_tag() {
  # latest tag merged at release branch
  # refs: https://git-scm.com/docs/git-for-each-ref/en
  if [[ "$LATEST_TAG" == "" ]] ; then
    create_tag
  else
    if [ $ITERATE = true ] ; then
      iterate_tag
      create_tag
    else
      MSG_ONE="Latest tag is:"
      MSG_TWO="$LATEST_TAG"
      print_message
      confirm_iterate
    fi
  fi
}

main() {
  # get branch name
  BRANCH_FULL_NANE=`git branch --show-current`
  # split name with / char
  IFS="/"
  read -ra SPLIT_IFS <<< "$BRANCH_FULL_NANE"

  # get branch prefix:
  #   - feature
  #   - support
  #   - release
  #   - hotfix
  #   - main
  #   - develop
  BRANCH_PREFIX=${SPLIT_IFS[0]}

  # get release version number
  VERSION_NUMBER=${SPLIT_IFS[1]}

  LATEST_TAG=`git for-each-ref --count=1 --sort=-refname --format '%(tag)' refs/tags/v$VERSION_NUMBER* --merged`

  if [ $BRANCH_PREFIX != "release" ] ; then
    MSG_ONE="This is not a release branch."
    MSG_TWO="Please, checkout to create a pre-release tag."
    print_message
    exit 0
  fi

  TYPE=""
  MESSAGE=""
  ITERATE=false
  PUSH=false

  PARAMS=""

  while (( "$#" )); do
    case "$1" in
      -t|--type)
        if [[ "$2" == "alpha" || "$2" == "beta" || "$2" == "rc" ]] ; then
          TYPE=$2
          LATEST_TAG=`git for-each-ref --count=1 --sort=-refname --format '%(tag)' refs/tags/v$VERSION_NUMBER-$TYPE* --merged`
          shift
        else
          echo "Value '$2' for TYPE is invalid."
        fi
        ;;
      -m|--message)
        MESSAGE=$2
        shift
        ;;
      -i|--iterate)
        ITERATE=true
        shift
        ;;
      -p|--push)
        PUSH=true
        shift
        ;;
      -h|--help)
        print_usage
        exit 1
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
  get_latest_tag
}

main "$@"