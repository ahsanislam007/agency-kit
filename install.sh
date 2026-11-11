#!/usr/bin/env bash
# Install unified agent kit into a project root (missing files only; never overwrite).
set -euo pipefail
SRC="$(cd "$(dirname "$0")" && pwd)"
DEST="${1:-.}"
DEST="$(cd "$DEST" && pwd)"

copy_missing() {
  local from="$1" to="$2"
  if [[ -e "$to" ]]; then
    echo "skip (exists): $to"
    return 0
  fi
  mkdir -p "$(dirname "$to")"
  if [[ -d "$from" ]]; then
    cp -R "$from" "$to"
  else
    cp "$from" "$to"
  fi
  echo "added: $to"
}

copy_missing "$SRC/AGENTS.md" "$DEST/AGENTS.md"
copy_missing "$SRC/CLAUDE.md" "$DEST/CLAUDE.md"
copy_missing "$SRC/GEMINI.md" "$DEST/GEMINI.md"
copy_missing "$SRC/.cursorignore" "$DEST/.cursorignore"

if [[ ! -d "$DEST/.agents" ]]; then
  cp -R "$SRC/.agents" "$DEST/.agents"
  echo "added: $DEST/.agents"
else
  echo "skip (exists): $DEST/.agents"
fi

bash "$DEST/.agents/sync.sh"
echo "Installed unified agent kit into $DEST"
