#!/usr/bin/env bash
# Placeholder project hook — ensure graphify extract exists when missing.
# Shared by Claude + Cursor via .agents/hooks (synced into .claude/hooks and .cursor/hooks).
set -euo pipefail

# Cursor passes JSON on stdin; Claude may too — consume safely.
cat >/dev/null || true

ROOT="${CURSOR_PROJECT_DIR:-${CLAUDE_PROJECT_DIR:-$(pwd)}}"
cd "$ROOT" 2>/dev/null || exit 0

if [[ ! -f graphify-out/graph.json ]]; then
  if command -v graphify >/dev/null 2>&1; then
    graphify extract . --code-only >/dev/null 2>&1 || true
    graphify cluster-only . --no-label >/dev/null 2>&1 || true
  fi
fi

exit 0
