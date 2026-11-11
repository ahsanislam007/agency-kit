---
name: agency-compound-engineering
description: >
  Bridge Compound Engineering (ce-* plugin skills) into agency routing.
  Use when substantive git-repo work should run CE’s brainstorm → plan → work →
  compound loop alongside agency-project-gateway, or when the user asks for CE,
  /ce-*, compound engineering, or knowledge capture after a change.
  Do NOT use to replace gateway, Lazyweb→Stitch, or Task spawn maps; do not
  vendor or rewrite CE’s 37 skills into agency-*.
disable-model-invocation: false
---

# Agency × Compound Engineering (bridge)

CE **augments** agency. Gateway stays prime for multi-role routing; CE owns the
single-change engineering loop and learnings capture.

Upstream plugin: [EveryInc/compound-engineering-plugin](https://github.com/EveryInc/compound-engineering-plugin)  
Install (Cursor): marketplace plugin `compound-engineering` (already preferred).

## Repo gate

**Skip** for home / no-git / trivial Q&A. Same gate as `agency-project-gateway`.

## Ownership

| Layer | Owns |
|-------|------|
| `agency-project-gateway` | Triage, context packet, specialist spawn, UI/arch/mobile/RE/pentest pipelines |
| CE core loop (`/ce-ideate` → `/ce-brainstorm` → `/ce-plan` → `/ce-work` → `/ce-compound`) | Shape → bound → build → capture for one change |
| `agency-*` specialists | Domain execution (UI, Android, backend, QA, …) after packet |

**Never:** CE replaces `Task` spawn; agency reimplements CE skill bodies; CE skips Lazyweb→Stitch on product UI.

## Phase map

| Agency moment | CE skill (when useful) |
|---------------|-------------------------|
| Ambiguous product shape before packet Done-when | `/ce-brainstorm` (optional `/ce-ideate` first) |
| Packet filled; multi-step impl needs U-IDs / test scenarios | `/ce-plan` — fold outputs into packet Goal / Done-when |
| Specialist building from a plan | `/ce-work` **or** platform engineer with plan path in packet |
| Diff/PR ready | `/ce-code-review` (pairs with `agency-qa-security`) |
| Change landed | `/ce-compound` → `docs/solutions/` (default CE artifact root) |
| “How/why does this work?” | `/ce-explain` |
| Judgment / alternatives | `/ce-pov` / `/ce-bakeoff` |
| Autopilot to PR | `/lfg` — still run gateway first if multi-lane agency work |

Operator cheat sheet + examples: `reference.md` in this folder.

## Procedure (gateway hook)

After packet fill (`agency-context-packet`), before or between specialist spawns:

1. If product shape is unsettled → run `/ce-brainstorm` (then refresh packet).
2. If impl is multi-step and no plan artifact → run `/ce-plan`; put plan path in packet `Stack / module paths` or Constraints.
3. Spawn specialists with the **same** packet (CE artifacts are inputs, not a second packet).
4. After ship / merge-ready → `/ce-compound` (and `agency-feature-docs` when user-facing).
5. Fill packet line when CE ran: `CE: loop=<ideate|brainstorm|plan|work|compound|n/a> | plan=<path|n/a> | solutions=<path|n/a>`

## Anti-patterns

- Calling `/ce-work` or `/lfg` before gateway on agency-team work
- Porting CE skills into `~/.agents/skills/agency-*` copies
- Skipping `/ce-compound` when the change produced a reusable lesson
- Treating CE `docs/plans/` as a substitute for Lazyweb/Stitch UI research

## Done when

Bridge applied for the workstream: gateway still first; CE phase(s) chosen by condition above; packet carries CE paths when used; learnings captured via `/ce-compound` when the change taught something non-obvious.
