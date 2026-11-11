# `.agents/` — unified agent kit (IDE-agnostic)

**Edit only here.** Then run:

```bash
bash .agents/sync.sh
```

That materializes tool-specific views so every developer gets the same behavior
whether they use Claude Code, Cursor, Codex, Gemini, or another agent IDE.

## Layout

```
.agents/
  skills/     # SKILL.md folders (Claude + Cursor skills)
  agents/     # Subagent markdown definitions
  rules/      # Shared rules (YAML frontmatter + markdown body)
  hooks/      # Shared shell hooks + IDE hook manifests
  sync.sh     # Writes/symlinks into .claude/ and .cursor/ (--global: agent home dirs)
AGENTS.md     # Project instructions (read by most tools natively)
CLAUDE.md     # Thin @AGENTS.md import for Claude Code
GEMINI.md     # Thin @AGENTS.md import for Gemini CLI
```

## What each IDE sees after sync

| IDE | Instructions | Skills | Agents | Rules | Hooks |
|---|---|---|---|---|---|
| Claude Code | `CLAUDE.md` → `AGENTS.md` | `.claude/skills` | `.claude/agents` | `.claude/rules` | `.claude/hooks` + settings |
| Cursor | `AGENTS.md` + `.cursor/rules` | `.cursor/skills` | `.cursor/agents` | `.cursor/rules/*.mdc` | `.cursor/hooks` |
| Codex / Copilot / others | `AGENTS.md` | (use skills if supported) | — | — | — |

## Global install (every agent on this machine)

```bash
AGENTS_SYNC_DRY_RUN=1 bash .agents/sync.sh --global   # preview
bash .agents/sync.sh --global                         # link
```

Links each skill, agent, and rule into the agents' home dirs with absolute symlinks,
so edits here are live everywhere. Other items in those dirs are left alone.

| Kit part | Linked into |
|---|---|
| Skills | `~/.agents/skills` (Codex, Gemini CLI, OpenCode, Copilot), `~/.claude/skills`, `~/.cursor/skills`, `~/.gemini/antigravity/skills`, `~/.trae/skills`, `~/.kiro/skills`, `~/.factory/skills`, `~/.hermes/skills`, `~/.codeium/windsurf/skills` (only agents whose home dir exists) |
| Agents | `~/.claude/agents`, `~/.cursor/agents` |
| Agents as skills | `~/.trae/skills`, `~/.gemini/antigravity/skills` — no file-based subagents there, so each agent ships as `~/.agents/personas/<agent>/SKILL.md` (a link to the agent file). Persona folders that bundle their own files are kept. |
| Rules | `~/.claude/rules/*.md`, `~/.cursor/rules/*.mdc` |

A real file or foreign symlink with the same name is skipped and reported. Re-run with
`AGENTS_SYNC_FORCE=1` to move it to `~/.agents/backups/<timestamp>/` and link the kit
version instead. Re-run after adding or renaming a skill, agent, or rule; dangling links
into the kit are pruned.

## Rules

1. Never hand-edit `.claude/**` or `.cursor/skills|agents|rules|hooks` copies — they are sync outputs. The same goes for the global links in `~/.claude`, `~/.cursor`, `~/.agents/skills`, etc.
2. Keep `AGENTS.md` as the only long-form project instruction file.
3. Prefer symlinks (default). Use `AGENTS_SYNC_MODE=copy bash .agents/sync.sh` on Windows or when symlinks are blocked.
