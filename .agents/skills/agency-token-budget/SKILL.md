---
name: agency-token-budget
description: >
  Token-saving operating rules for agency work in any agent (Cursor, Claude
  Code, Codex, …). Use when optimizing
  spend/context, planning multi-agent runs, choosing explore vs graphify, or
  when the user asks to save tokens / reduce context usage. Also use when an
  agency run risks parallel over-spawn or dump-heavy prompts.
  Do NOT use for home/no-repo trivial Q&A that never launches agents, and do
  not invent dollar costs from guesses.
disable-model-invocation: false
---

# Agency token budget

Keep agency runs cheap: orient narrowly, packet once, specialize sparsely.

## Repo gate

**Skip / no-op** for pure home / no-repo workspaces with no project edits. Token discipline still applies to any chat, but agency budgets below assume a git repo.

## When to use

- Planning or launching `agency-*` Task agents
- User asks to save tokens / reduce context
- Orienting in a large repo (graphify vs explore)

## Hard budget

| Phase | Limit |
|---|---|
| Orient | graphify (if present) **OR** 1 explore pass — not both full dumps |
| Read | ≤ **3** focused files before clarifying OR acting |
| Agents | **1 router** (`agency-project-gateway`) + only needed specialists; no duplicate UI agents |
| Models | cheap/fast for explore/shell/docs; strong only for hard reasoning |
| UI research | Lazyweb search (+ report when high-stakes) then Stitch — **one** pipeline per workstream |
| Diagrams | `agency-archify` once per map workstream — deliver HTML path, do not paste IR dumps |
| Packet | ≤ ~25 lines (`agency-context-packet`) |

## Procedure

1. Confirm git repo for agency routing; else answer without spawning agents.
2. Orient with graphify **or** one explore — stop when you can act or must ask.
3. Read ≤3 files; ask if still ambiguous.
4. Build one context packet; launch the smallest specialist set.
5. Prefer MCP tools (Lazyweb, Stitch, Supabase, snapshots) over pasting dumps.
6. After the turn: glance at context ring / Usage Summary — do not invent `$` costs.

## Do

- `move_agent_to_root` before project edits
- Put SOPs in skills/rules; keep chat prompts short
- Use `.cursorignore` so builds/deps stay out of index
- Reuse packet fields; never re-run identical Lazyweb/Stitch calls

## Don't

- Parallel 5+ agency agents on an ambiguous ask
- Paste brand books, full lockfiles, or huge logs into chat
- Use `agency-u-ux-designer` when `agency-ui-ux-designer` exists
- Full tree dumps into the parent timeline

## Anti-patterns

- Explore + graphify dump + 3 specialists before clarifying the goal
- Re-fetching the same Lazyweb search in every agent
- Measuring success in invented dollar amounts

## Verification checklist

- [ ] Repo gate checked
- [ ] Orient stayed within one pass
- [ ] ≤3 focused reads before act/ask
- [ ] Agent count justified (router + needed only)
- [ ] No dump pastes; paths/MCP used instead

## Observability (after each turn)

- Cursor IDE: context ring + Usage Summary = Always
- Cursor log: `~/.cursor/logs/token-usage.jsonl` via hooks (if present)
- Cursor CLI: status line + `/context` + `/usage` + `cursor-usage`
- Claude Code: `/context` + `/cost`
