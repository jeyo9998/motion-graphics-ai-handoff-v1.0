#!/usr/bin/env bash
# Count ZIP entry file-name extensions, or read entry names from stdin when the
# single argument is '-'. Directories (entries ending in '/') are ignored.
# Extension = suffix after the last dot in the basename, lowercased.
# [no extension] = no dot, a single-dot dotfile (for example .gitignore),
# or a basename ending in a dot (for example name.).

set -euo pipefail

usage() {
  printf 'Usage: %s <archive.zip|->\n' "${0##*/}" >&2
  printf '  Use - to read ZIP entry names, one per line, from stdin.\n' >&2
}

if [[ $# -ne 1 ]]; then
  usage
  exit 64
fi

source_arg=$1
if [[ "$source_arg" != "-" ]]; then
  if [[ ! -f "$source_arg" ]]; then
    printf 'ERROR: archive is not a readable regular file: %s\n' "$source_arg" >&2
    exit 66
  fi
  if ! command -v unzip >/dev/null 2>&1; then
    printf 'ERROR: unzip is required to read ZIP archives.\n' >&2
    exit 69
  fi
fi

if [[ "$source_arg" == "-" ]]; then
  cat
else
  unzip -Z1 "$source_arg"
fi | awk '
  !/\/$/ {
    name = $0
    sub(/^.*\//, "", name)

    if (name !~ /\./ || name ~ /^\.[^.]+$/ || name ~ /\.$/) {
      ext = "[no extension]"
    } else {
      sub(/^.*\./, "", name)
      ext = "." tolower(name)
    }

    count[ext]++
  }
  END {
    for (ext in count) print ext, count[ext]
  }
' | LC_ALL=C sort
