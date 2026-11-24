#!/usr/bin/env bash
# Regression tests for evals/project-understanding/scripts/count-extensions.sh
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
COUNTER="$ROOT/evals/project-understanding/scripts/count-extensions.sh"
TMP_DIR="$(mktemp -d)"
trap 'rm -rf "$TMP_DIR"' EXIT

cat > "$TMP_DIR/entries.txt" <<'ENTRIES'
folder/
a.b/Makefile
.gitignore
Photo.PNG
x.tar.gz
trailingdot.
file..
.a.b
folder/sub/Some.MOV
noext
ENTRIES

cat > "$TMP_DIR/expected-stdin.txt" <<'EXPECTED'
.b 1
.gz 1
.mov 1
.png 1
[no extension] 5
EXPECTED

"$COUNTER" - < "$TMP_DIR/entries.txt" > "$TMP_DIR/actual-stdin.txt"
diff -u "$TMP_DIR/expected-stdin.txt" "$TMP_DIR/actual-stdin.txt"

python3 - "$TMP_DIR/sample.zip" <<'PY'
import sys
from zipfile import ZipFile

with ZipFile(sys.argv[1], "w") as archive:
    for name in (
        "folder/",
        "a.b/Makefile",
        ".gitignore",
        "Photo.PNG",
        "x.tar.gz",
        "trailingdot.",
        ".a.b",
    ):
        archive.writestr(name, b"")
PY

cat > "$TMP_DIR/expected-zip.txt" <<'EXPECTED'
.b 1
.gz 1
.png 1
[no extension] 3
EXPECTED

"$COUNTER" "$TMP_DIR/sample.zip" > "$TMP_DIR/actual-zip.txt"
diff -u "$TMP_DIR/expected-zip.txt" "$TMP_DIR/actual-zip.txt"

if "$COUNTER" "$TMP_DIR/missing.zip" >/dev/null 2>&1; then
  echo 'FAIL: missing archive should return a non-zero status.' >&2
  exit 1
fi

printf 'this is not a ZIP archive\n' > "$TMP_DIR/corrupt.zip"
if "$COUNTER" "$TMP_DIR/corrupt.zip" >/dev/null 2>&1; then
  echo 'FAIL: corrupt archive should return a non-zero status.' >&2
  exit 1
fi

if "$COUNTER" >/dev/null 2>&1; then
  echo 'FAIL: missing argument should return a non-zero status.' >&2
  exit 1
fi

printf 'count-extensions tests: PASS\n'
