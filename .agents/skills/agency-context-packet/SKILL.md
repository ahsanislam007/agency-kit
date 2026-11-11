---
name: agency-context-packet
description: >
  Build and pass a short shared context packet when routing agency work.
  Use when launching agency-* subagents, chief-of-staff planning, or multi-agent
  handoffs so specialists inherit goal/constraints/paths/Lazyweb + Stitch links
  without re-exploring the whole repo. Also use when a specialist prompt lacks
  Goal/Done-when or when UI agents would otherwise re-run Lazyweb/Stitch.
  Do NOT use for home/no-repo workspaces, trivial Q&A, or single-agent tasks
  that need no handoff.
disable-model-invocation: false
---

# Agency context packet

One packet per workstream. Paste the same packet into every `agency-*` Task prompt.

## Repo gate

**Skip / no-op** when there is no git repository, or the workspace is home / empty-window only. Packets are for project-scoped agency routing.

## When to use

- Launching any `agency-*` specialist or parallel Task agents
- Gateway / chief-of-staff planning handoffs
- UI work that must carry Lazyweb + Stitch fields

## When to skip

- No git repo / home-only workspace
- Trivial Q&A (no code/design changes)
- Single narrow edit with no delegation

## Packet template (≤ ~25 lines)

```markdown
## Context packet
- Goal:
- Done when:
- Non-goals:
- Stack / module paths: (3 paths max)
- Constraints: (reuse deps, no drive-by refactors, …)
- Lazyweb (UI only): search query + platform + report URL(s) + 2-3 key patterns
- Stitch (UI only): project id + screen id(s) + image/code paths
- Motion: web=agency motion language (optional demo ahsanislam.com) | mobile=compose/swift springs | gsap|transitions-dev|n/a
- 21st (React supply): search query + component id(s)/slug(s) + installed paths | React Bits fallback | n/a
- Designlang / WebCraft: url extract|taste opt-in|transitions-agent|n/a
- Archify (diagrams): type + HTML path + JSON path
- AgentReach (live web research): used=<yes|no|n/a> + channels + notes
- FeatureDocs (after user-facing features): yes|n/a | guide=<path> | screenshots=docs/assets/<slug>/ | status=pending|done|todo-screenshots
- CE (compound-engineering): loop=<ideate|brainstorm|plan|work|compound|n/a> | plan=<path|n/a> | solutions=<path|n/a>
- Security (RE / pentest only): REA: … | AndroidRE: … | PentAGI: target + permission (line formats in those skills)
- Playwright (web E2E only): setup=<agency-web-test-setup|n/a> | authoring=<agency-playwright-testing|n/a> | baseURL=… | CI=chromium-smoke|n/a
- Open questions:
- Out of scope files:
```

Fill every bullet. Use `n/a` for non-UI Lazyweb/Stitch/Motion, non-React 21st, non-diagram Archify, non-fetch AgentReach, non-feature FeatureDocs, unused CE, non-security Security, and non-web-E2E Playwright fields — do not omit lines.
On reverse-engineering / pentest workstreams, Security is required; PentAGI needs target + written permission before any active test.
On UI workstreams, Motion is required (`agency-rich-ui`); static UI = incomplete Done-when.
On React/Tailwind/shadcn implement, 21st is required when catalog supply was used (`agency-21st`); otherwise `n/a`.
On architecture/docs map workstreams, Archify is required (`agency-archify`); Mermaid-only = incomplete Done-when unless the user asked for Mermaid.
On live URL/video/repo/open-web research (outside Lazyweb screens), AgentReach is required (`agency-agent-reach`).
On Compound Engineering strengthen (`agency-compound-engineering`), set CE loop + plan/solutions paths when `ce-*` ran; otherwise `CE: … | n/a`.
On **new app / bootstrap** workstreams, also require: module tree + convention plugin ids + first feature MVI types (`agency-app-architecture`).

## Procedure

1. Confirm git repo + project root (`move_agent_to_root` if needed).
2. Draft packet from the user ask; keep paths, not dumps.
3. If UI/design → run `agency-ui-pipeline` first; then fill Lazyweb + Stitch.
4. If architecture / sequence / workflow / data-flow / lifecycle diagram → run `agency-archify`; then fill Archify.
5. If new app / bootstrap / multi-module Android-KMP → load `agency-app-architecture`; fill module tree + plugins + MVI types in Constraints or Stack.
6. If Goal or Done-when empty → ask once; do not spawn a swarm.
7. Paste the identical packet into each specialist prompt.
8. Optional after implement: `agency-qa-security` / review gate.

## Rules

1. **One packet per workstream** — no per-agent rediscovery.
2. **Paths over dumps** — never paste large schemas/logs/brand books.
3. **Canonical UI agent** — `agency-ui-ux-designer` (not `agency-u-ux-designer`).
4. **Routers fill; specialists consume** — specialists do not re-run Lazyweb/Stitch/Archify unless those fields are empty.

## Anti-patterns

- Empty Goal/Done-when with 3+ agents launched
- Pasting full Lazyweb reports instead of 2–3 patterns + URL
- Different packets per specialist for the same workstream
- Building packets for no-repo / home chat

## Verification checklist

- [ ] Git repo present (else skipped)
- [ ] Goal + Done-when non-empty
- [ ] ≤3 module paths; no huge dumps
- [ ] UI work → Lazyweb + Stitch + Motion fields filled or explicitly `n/a` with reason
- [ ] Diagram work → Archify fields filled or explicitly `n/a` with reason
- [ ] Same packet text reused across agents

## Failure modes

| Failure | Action |
|---|---|
| Ambiguous project path | Ask; do not invent a folder |
| UI fields empty at specialist start | Router runs `agency-ui-pipeline` before relaunch |
| Archify fields empty on diagram work | Router runs `agency-archify` before relaunch |
| Packet > ~25 lines | Cut dumps; keep paths + decisions only |
