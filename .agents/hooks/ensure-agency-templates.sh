#!/usr/bin/env bash
# On sessionStart:
# 1. Sync global ~/.cursor agents/skills from agent-kit template when template is newer
# 2. Install unified agent-kit into git repos (missing files only)
set -euo pipefail

input="$(cat)"
KIT_ROOT="$(cd "$(dirname "$0")/../.." && pwd)"
TEMPLATE_ROOT="${CURSOR_AGENCY_TEMPLATE:-$KIT_ROOT}"
TEMPLATE_AGENTS="$TEMPLATE_ROOT/.agents"
GLOBAL_CURSOR="$HOME/.cursor"
HOME_RESOLVED="$(cd "$HOME" 2>/dev/null && pwd -P)"

sync_global_from_template() {
  [[ -d "$TEMPLATE_AGENTS" ]] || return 0

  local template_stamp global_stamp
  template_stamp="$(find "$TEMPLATE_AGENTS" -type f -print0 2>/dev/null | xargs -0 stat -f '%m' 2>/dev/null | sort -n | tail -1 || echo 0)"
  global_stamp="$(find "$GLOBAL_CURSOR/agents" -type f -print0 2>/dev/null | xargs -0 stat -f '%m' 2>/dev/null | sort -n | tail -1 || echo 0)"

  if [[ "$template_stamp" -gt "$global_stamp" ]]; then
    rsync -a --delete "$TEMPLATE_AGENTS/agents/" "$GLOBAL_CURSOR/agents/" 2>/dev/null || true
    mkdir -p "$GLOBAL_CURSOR/skills"
    for skill in agency-ui-pipeline agency-context-packet agency-token-budget stitch-design agency-rich-ui agency-archify; do
      if [[ -d "$TEMPLATE_AGENTS/skills/$skill" ]]; then
        rsync -a "$TEMPLATE_AGENTS/skills/$skill/" "$GLOBAL_CURSOR/skills/$skill/" 2>/dev/null || true
      fi
    done
  fi
}

is_git_repo() {
  local root="$1"
  git -C "$root" rev-parse --is-inside-work-tree >/dev/null 2>&1
}

is_home_or_empty() {
  local root="$1"
  local resolved
  resolved="$(cd "$root" 2>/dev/null && pwd -P || echo "$root")"
  [[ "$resolved" == "$HOME_RESOLVED" ]] && return 0
  [[ -z "${root// }" ]] && return 0
  return 1
}

sync_global_from_template

roots=()
if command -v python3 >/dev/null 2>&1; then
  while IFS= read -r line; do
    [[ -n "$line" ]] && roots+=("$line")
  done < <(python3 - "$input" <<'PY' || true
import json, sys
raw = sys.argv[1] if len(sys.argv) > 1 else ""
try:
    data = json.loads(raw) if raw.strip() else {}
except Exception:
    data = {}
roots = []
for key in ("workspaceRoots", "workspace_roots"):
    val = data.get(key)
    if isinstance(val, list):
        roots.extend(str(x) for x in val)
for key in ("cwd", "workspace_root", "workspaceRoot"):
    val = data.get(key)
    if isinstance(val, str) and val:
        roots.append(val)
for r in roots:
    print(r)
PY
)
fi

if [[ ${#roots[@]} -eq 0 ]]; then
  roots+=("$(pwd)")
fi

for root in "${roots[@]}"; do
  [[ -d "$root" ]] || continue
  is_home_or_empty "$root" && continue
  is_git_repo "$root" || continue
  [[ -d "$TEMPLATE_ROOT" ]] || continue
  if [[ ! -d "$root/.agents" && ! -f "$root/AGENTS.md" ]]; then
    bash "$TEMPLATE_ROOT/install.sh" "$root" >/dev/null 2>&1 || true
  elif [[ -f "$root/.agents/sync.sh" ]]; then
    if [[ ! -e "$root/.claude/skills" || ! -e "$root/.cursor/skills" ]]; then
      bash "$root/.agents/sync.sh" >/dev/null 2>&1 || true
    fi
  fi
done

exit 0
