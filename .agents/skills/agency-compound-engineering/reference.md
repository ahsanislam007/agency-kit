# Agency × CE — operator guide

## Install hosts

| Host | Install |
|------|---------|
| Cursor | Marketplace: `compound-engineering` (or `/add-plugin compound-engineering`) |
| Claude Code | `/plugin marketplace add EveryInc/compound-engineering-plugin` then `/plugin install compound-engineering` |
| Codex | Marketplace add `EveryInc/compound-engineering-plugin` @ `main`, then install plugin |

Agency bridge skill lives only at `~/.agents/skills/agency-compound-engineering/` — do not clone CE into app repos.

## Core loop (CE)

```text
[/ce-ideate] → /ce-brainstorm → /ce-plan → /ce-work → /ce-compound
```

`/ce-compound` writes to `docs/solutions/` (or `<docs_root>/solutions/` if configured). Next brainstorm/plan reads those.

## When agency uses which CE skill

| Situation | Invoke |
|-----------|--------|
| “What should we build?” unsettled | `/ce-brainstorm` |
| Need bounded plan + U-IDs | `/ce-plan` |
| Execute a ready plan | `/ce-work` or agency platform engineer |
| Review diff/PR | `/ce-code-review` |
| Capture lesson after ship | `/ce-compound` |
| Explain existing behavior | `/ce-explain` |
| Hands-off to open PR | `/lfg` (gateway first if multi-lane) |

## Example A — feature in xeonqr

1. Gateway → packet (Goal / Done-when / paths).
2. If UI: `agency-ui-pipeline` (Lazyweb → Stitch) + `agency-rich-ui`.
3. Optional: `/ce-plan` with Stitch paths in Constraints; add plan path to packet.
4. Spawn `agency-frontend-web-engineer` (or platform fit) with same packet.
5. `/ce-code-review` on the diff; `agency-qa-security` if risk warrants.
6. `agency-feature-docs` + `/ce-compound`.

## Example B — UI redesign

1. Gateway → Lazyweb → Stitch → packet Motion line.
2. Do **not** use CE polish/prototype as a substitute for Stitch.
3. `/ce-brainstorm` only if product requirements are still open after Stitch.
4. Implement via UI agent + engineer; close with `/ce-compound` if patterns are reusable.

## Packet CE line

```markdown
- CE: loop=<ideate|brainstorm|plan|work|compound|n/a> | plan=<path|n/a> | solutions=<path|n/a>
```

## Non-goals

Replace gateway; vendor CE into xeonqr; rewrite all agency skills to mirror CE; require CE on trivial Q&A.
