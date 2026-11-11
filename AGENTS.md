# Agency kit — agent instructions

> IDE-agnostic source of truth. Edit `.agents/**` + this file, then run `bash .agents/sync.sh`.

## What this is

An **agency operating system** for AI coding agents: a prime gateway, context packet, specialist agents, and skills for UI (Lazyweb→Stitch), rich motion, mobile/web test setup, architecture maps, and authorized RE/pentest lanes.

## Agent kit

| Path | Purpose |
|---|---|
| `.agents/skills/` | Skills (`SKILL.md` SOPs) |
| `.agents/agents/` | Subagent definitions |
| `.agents/rules/` | Always-on / glob rules |
| `.agents/hooks/` | Shared hook scripts |
| `bash .agents/sync.sh` | Materialize `.claude/` + `.cursor/` |
| `bash .agents/sync.sh --global` | Link into agent home dirs |

## Routing

1. **`agency-project-gateway` first** for substantive git-repo agency work.
2. Multi-step → `agency-chief-of-staff` after gateway triage.
3. UI/design: Lazyweb refs → Stitch design (`agency-ui-pipeline`); React implement supply via `agency-21st`.
4. Architecture diagrams: `agency-archify`.
5. Product UI motion is mandatory (`agency-rich-ui`) — not YAGNI.
6. Ponytail: lazy-senior minimalism for coding (`ponytail` skill).
7. Use graphify before broad codebase exploration when `graphify-out/` exists.

## Canonical UI agent

`agency-ui-ux-designer` (never the deprecated `agency-u-ux-designer` alias alone).

## External deps (not vendored)

MCPs and engines are documented in [docs/mcp-prerequisites.md](docs/mcp-prerequisites.md): Maestro, Playwright, 21st, Lazyweb, Stitch, Archify, Agent Reach, Compound Engineering plugin, PentAGI runtime.
