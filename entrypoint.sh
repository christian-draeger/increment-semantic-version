#!/bin/bash -l

# active bash options:
#   - stops the execution of the shell script whenever there are any errors from a command or pipeline (-e)
#   - option to treat unset variables as an error and exit immediately (-u)
#   - print each command before executing it (-x)
#   - sets the exit code of a pipeline to that of the rightmost command
#     to exit with a non-zero status, or to zero if all commands of the
#     pipeline exit successfully (-o pipefail)
set -euo pipefail

main() {

  prev_version="$1"; releaseType="$2"

  if [[ "$prev_version" == "" ]]; then
    echo "could not read previous version"; exit 1
  fi

  possibleReleaseTypes="major feature bug alpha beta rc"

  if [[ ! ${possibleReleaseTypes[*]} =~ ${releaseType} ]]; then
    echo "valid argument: [ ${possibleReleaseTypes[*]} ]"; exit 1
  fi

  major=0; minor=0; build=0; pre=""; preversion=0

  # break down the version number into it's components
  regex="^([0-9]+).([0-9]+).([0-9]+)((-[a-z]+)([0-9]+))?$"
  if [[ $prev_version =~ $regex ]]; then
    major="${BASH_REMATCH[1]}"
    minor="${BASH_REMATCH[2]}"
    build="${BASH_REMATCH[3]}"
    pre="${BASH_REMATCH[5]}"
    preversion="${BASH_REMATCH[6]}"
  else
    echo "previous version '$prev_version' is not a symantic version"
    exit 1
  fi

  # increment version number based on given release type
  case "$releaseType" in
  "major")
    ((major++)); minor=0; build=0; pre="";;
  "feature")
    ((minor++)); build=0; pre="";;
  "bug")
    ((build++)); pre="";;
  "alpha")
    ((preversion++))
    if [[ "$pre" != "-alpha" ]]; then
      preversion=1
    fi
    pre="-alpha$preversion";;
  "beta")
    ((preversion++))
    if [[ "$pre" != "-beta" ]]; then
      preversion=1
    fi
    pre="-beta$preversion";;
  "rc")
    ((preversion++))
    if [[ "$pre" != "-rc" ]]; then
      preversion=1
    fi
    pre="-rc$preversion";;
  esac

  next_version="${major}.${minor}.${build}${pre}"
  echo "create $releaseType-release version: $prev_version -> $next_version"

  echo ::set-output name=next-version::"$next_version"
}

main "$1" "$2"
