#!/usr/bin/env bash
# Materialize IDE-specific agent trees from the canonical .agents/ kit.
# Default: symlinks (one source of truth). Override: AGENTS_SYNC_MODE=copy
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
AGENTS_ROOT="$ROOT/.agents"
MODE="${AGENTS_SYNC_MODE:-symlink}" # symlink | copy

link_or_copy() {
  local src="$1"
  local dest="$2"
  mkdir -p "$(dirname "$dest")"
  rm -rf "$dest"
  if [[ "$MODE" == "copy" ]]; then
    if [[ -d "$src" ]]; then
      cp -R "$src" "$dest"
    else
      cp "$src" "$dest"
    fi
  else
    local rel
    rel="$(python3 - "$src" "$dest" <<'PY'
import os, sys
src, dest = sys.argv[1], sys.argv[2]
print(os.path.relpath(src, os.path.dirname(dest)))
PY
)"
    ln -sfn "$rel" "$dest"
  fi
}

sync_rules_for_cursor() {
  local src_dir="$AGENTS_ROOT/rules"
  local dest_dir="$ROOT/.cursor/rules"
  mkdir -p "$dest_dir"
  # Remove previously synced rule files only (keep unrelated local rules)
  find "$dest_dir" -maxdepth 1 \( -name '*.mdc' -o -name '*.md' \) -type f -delete 2>/dev/null || true
  find "$dest_dir" -maxdepth 1 \( -name '*.mdc' -o -name '*.md' \) -type l -delete 2>/dev/null || true
  shopt -s nullglob
  for f in "$src_dir"/*; do
    [[ -f "$f" ]] || continue
    local base ext name dest
    base="$(basename "$f")"
    ext="${base##*.}"
    name="${base%.*}"
    if [[ "$ext" == "md" || "$ext" == "mdc" ]]; then
      dest="$dest_dir/${name}.mdc"
    else
      dest="$dest_dir/${base}.mdc"
    fi
    if [[ "$MODE" == "copy" ]]; then
      cp "$f" "$dest"
    else
      local rel
      rel="$(python3 - "$f" "$dest" <<'PY'
import os, sys
src, dest = sys.argv[1], sys.argv[2]
print(os.path.relpath(src, os.path.dirname(dest)))
PY
)"
      ln -sfn "$rel" "$dest"
    fi
  done
  shopt -u nullglob
}

sync_rules_for_claude() {
  local src_dir="$AGENTS_ROOT/rules"
  local dest_dir="$ROOT/.claude/rules"
  mkdir -p "$dest_dir"
  find "$dest_dir" -maxdepth 1 \( -name '*.md' -o -name '*.mdc' \) \( -type f -o -type l \) -delete 2>/dev/null || true
  shopt -s nullglob
  for f in "$src_dir"/*; do
    [[ -f "$f" ]] || continue
    local base ext name dest
    base="$(basename "$f")"
    ext="${base##*.}"
    name="${base%.*}"
    dest="$dest_dir/${name}.md"
    if [[ "$MODE" == "copy" ]]; then
      cp "$f" "$dest"
    else
      local rel
      rel="$(python3 - "$f" "$dest" <<'PY'
import os, sys
src, dest = sys.argv[1], sys.argv[2]
print(os.path.relpath(src, os.path.dirname(dest)))
PY
)"
      ln -sfn "$rel" "$dest"
    fi
  done
  shopt -u nullglob
}

# --- Global install: `sync.sh --global` links the kit into every agent's home dir ---
# Links are absolute (~/.gemini/antigravity/skills is itself a symlink, so relative
# links break there) and per item, so other skills/agents/rules in those dirs are kept.
# AGENTS_SYNC_DRY_RUN=1 previews. Entries not owned by this kit are skipped unless
# AGENTS_SYNC_FORCE=1, which first moves them to ~/.agents/backups/<timestamp>/.
GLOBAL_SKILL_DIRS=(
  "$HOME/.agents/skills"             # shared: Codex, Gemini CLI, OpenCode, Copilot, Cursor
  "$HOME/.claude/skills"             # Claude Code (Cursor reads it too)
  "$HOME/.cursor/skills"
  "$HOME/.gemini/antigravity/skills"
  "$HOME/.trae/skills"
  "$HOME/.kiro/skills"
  "$HOME/.factory/skills"
  "$HOME/.hermes/skills"
  "$HOME/.codeium/windsurf/skills"
)
# Trae and Antigravity have no file-based subagents, so kit agents ship there as
# skills: ~/.agents/personas/<agent>/SKILL.md links to the agent file.
PERSONA_ROOT="$HOME/.agents/personas"
PERSONA_SKILL_DIRS=("$HOME/.trae/skills" "$HOME/.gemini/antigravity/skills")
DRY_RUN="${AGENTS_SYNC_DRY_RUN:-0}"
FORCE="${AGENTS_SYNC_FORCE:-0}"
CHANGES=0
SKIPPED=0

run() {
  if [[ "$DRY_RUN" == 1 ]]; then echo "    (dry-run) $*"; else "$@"; fi
}

# Symlink into this kit — absolute, or relative from an older sync.
owned_link() {
  local target
  [[ -L "$1" ]] || return 1
  target="$(readlink "$1")"
  [[ "$target" == "$AGENTS_ROOT"/* || "$target" == "$PERSONA_ROOT"/* ||
     "$target" == *"/$(basename "$ROOT")/.agents/"* ]]
}

global_link() {
  local src="$1" dest="$2" rel bak
  [[ -L "$dest" && "$(readlink "$dest")" == "$src" ]] && return 0
  if [[ -e "$dest" || -L "$dest" ]] && ! owned_link "$dest"; then
    if [[ "$FORCE" != 1 ]]; then
      echo "  SKIP $dest (not from this kit)"
      SKIPPED=$((SKIPPED + 1))
      return 0
    fi
    rel="${dest#"$HOME"/}"
    bak="$BACKUP_DIR/$(printf '%s' "${rel#.}" | tr '/' '_')"
    run mkdir -p "$BACKUP_DIR"
    run mv "$dest" "$bak"
    echo "  backed up $dest -> $bak"
  fi
  run ln -sfn "$src" "$dest"
  echo "  linked $dest"
  CHANGES=$((CHANGES + 1))
}

prune_dangling() {
  local l
  for l in "$1"/*; do
    [[ -L "$l" && ! -e "$l" ]] && owned_link "$l" || continue
    run rm "$l"
    echo "  pruned dangling $l"
    CHANGES=$((CHANGES + 1))
  done
}

sync_global() {
  local d s ext name p
  BACKUP_DIR="$HOME/.agents/backups/$(date +%Y%m%d-%H%M%S)"
  echo "Global install from $AGENTS_ROOT (dry-run=$DRY_RUN, force=$FORCE)"

  for d in "${GLOBAL_SKILL_DIRS[@]}"; do
    if [[ ! -d "$(dirname "$d")" ]]; then
      echo "skills: skip $d (agent not installed)"
      continue
    fi
    echo "skills -> $d"
    [[ -d "$d" ]] || run mkdir -p "$d"
    prune_dangling "$d"
    for s in "$AGENTS_ROOT"/skills/*; do
      [[ -f "$s/SKILL.md" ]] || continue
      global_link "$s" "$d/$(basename "$s")"
    done
  done

  for d in "$HOME/.claude/agents" "$HOME/.cursor/agents"; do
    [[ -d "$(dirname "$d")" ]] || continue
    echo "agents -> $d"
    [[ -d "$d" ]] || run mkdir -p "$d"
    prune_dangling "$d"
    for s in "$AGENTS_ROOT"/agents/*.md; do
      global_link "$s" "$d/$(basename "$s")"
    done
  done

  # Cursor rules are .mdc; Claude Code rules are .md.
  for d in "$HOME/.claude/rules" "$HOME/.cursor/rules"; do
    [[ -d "$(dirname "$d")" ]] || continue
    ext=md
    [[ "$d" == */.cursor/rules ]] && ext=mdc
    echo "rules -> $d"
    [[ -d "$d" ]] || run mkdir -p "$d"
    prune_dangling "$d"
    for s in "$AGENTS_ROOT"/rules/*.md; do
      global_link "$s" "$d/$(basename "$s" .md).$ext"
    done
  done

  # Agents as skills. A same-name kit skill wins (agency-project-gateway).
  for p in "$PERSONA_ROOT"/*; do
    [[ -L "$p/SKILL.md" && ! -e "$p/SKILL.md" ]] || continue
    run rm -r "$p"
    echo "  pruned persona $p"
    CHANGES=$((CHANGES + 1))
  done
  for s in "$AGENTS_ROOT"/agents/*.md; do
    name="$(basename "$s" .md)"
    [[ -e "$AGENTS_ROOT/skills/$name" ]] && continue
    [[ -d "$PERSONA_ROOT/$name" ]] || run mkdir -p "$PERSONA_ROOT/$name"
    global_link "$s" "$PERSONA_ROOT/$name/SKILL.md"
  done
  for d in "${PERSONA_SKILL_DIRS[@]}"; do
    [[ -d "$d" ]] || continue
    echo "agents as skills -> $d"
    prune_dangling "$d"
    for s in "$AGENTS_ROOT"/agents/*.md; do
      name="$(basename "$s" .md)"
      [[ -e "$AGENTS_ROOT/skills/$name" ]] && continue
      # A persona folder that bundles its own scripts/assets is maintained by hand.
      if ! owned_link "$d/$name" && [[ -d "$d/$name" && -n "$(ls -A "$d/$name" | grep -vx SKILL.md)" ]]; then
        echo "  keep $d/$name (bundles its own files)"
        continue
      fi
      global_link "$PERSONA_ROOT/$name" "$d/$name"
    done
  done

  echo "Done: $CHANGES change(s), $SKIPPED skipped."
  if [[ "$SKIPPED" -gt 0 ]]; then
    echo "  Re-run with AGENTS_SYNC_FORCE=1 to back up and replace skipped entries."
  fi
}

if [[ "${1:-}" == "--global" ]]; then
  sync_global
  exit 0
fi

echo "Syncing agent kit from $AGENTS_ROOT (mode=$MODE)"

# Skills / agents / hooks — whole-tree link
link_or_copy "$AGENTS_ROOT/skills" "$ROOT/.claude/skills"
link_or_copy "$AGENTS_ROOT/agents" "$ROOT/.claude/agents"
link_or_copy "$AGENTS_ROOT/hooks" "$ROOT/.claude/hooks"

link_or_copy "$AGENTS_ROOT/skills" "$ROOT/.cursor/skills"
link_or_copy "$AGENTS_ROOT/agents" "$ROOT/.cursor/agents"
link_or_copy "$AGENTS_ROOT/hooks" "$ROOT/.cursor/hooks"

sync_rules_for_claude
sync_rules_for_cursor

# Cursor hooks manifest (points at shared scripts under .cursor/hooks → .agents/hooks)
if [[ -f "$AGENTS_ROOT/hooks/cursor-hooks.json" ]]; then
  cp "$AGENTS_ROOT/hooks/cursor-hooks.json" "$ROOT/.cursor/hooks.json"
fi

# Claude settings: write settings.json only when missing (never overwrite user settings)
if [[ -f "$AGENTS_ROOT/hooks/claude-settings.hooks.json" ]]; then
  mkdir -p "$ROOT/.claude"
  cp "$AGENTS_ROOT/hooks/claude-settings.hooks.json" "$ROOT/.claude/settings.hooks.json"
  if [[ ! -f "$ROOT/.claude/settings.json" ]]; then
    cp "$AGENTS_ROOT/hooks/claude-settings.hooks.json" "$ROOT/.claude/settings.json"
  fi
fi

# Optional Copilot adapter
if [[ -f "$AGENTS_ROOT/adapters/copilot-instructions.md" ]]; then
  mkdir -p "$ROOT/.github"
  cp "$AGENTS_ROOT/adapters/copilot-instructions.md" "$ROOT/.github/copilot-instructions.md"
fi

echo "Done."
echo "  Claude: .claude/{skills,agents,rules,hooks}"
echo "  Cursor: .cursor/{skills,agents,rules,hooks} + hooks.json"
echo "  Truth:  AGENTS.md + .agents/"
