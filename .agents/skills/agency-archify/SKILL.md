---
name: agency-archify
description: >
  Agency SOP for architecture, workflow, sequence, data-flow, and lifecycle
  diagrams via Archify (typed IR → validated self-contained HTML). Use when
  gateway/chief-of-staff/CTO/docs need a technical map, when the user asks to
  visualize system architecture or request/data flows, or when packet Archify
  fields are empty before architecture/docs handoff.
  Do NOT use for product UI screens (use agency-ui-pipeline), Mermaid-only
  sketches the user explicitly requested, home/no-repo trivial Q&A, or when
  packet already has Archify HTML paths filled.
disable-model-invocation: false
---

# Agency Archify: technical diagrams on demand

Canonical agency path for **architecture diagrams**. Routers run this once per
diagram workstream; specialists consume packet fields — do not re-author unless
Archify fields are empty.

## Engine

Underlying skill/runtime: `archify` at `~/.agents/skills/archify` (or
`$ARCHIFY_HOME` if set).

1. Read that skill’s `SKILL.md` and follow its authoring/validate/deliver path.
2. Prefer Archify HTML over inventing Mermaid/ASCII for agency deliverables.
3. CLI (from the archify skill root):

```bash
node bin/archify.mjs validate <type> <candidate.json> --quality showcase --json
node bin/archify.mjs deliver <type> <candidate.json> <output.html> --quality showcase --json
```

## Repo gate

**Skip / no-op** when there is no git repository or the workspace is home /
empty-window only — unless the user explicitly wants a description-only diagram
with no repo grounding. Description-only diagrams are allowed from any chat;
repo-backed maps require a project root (`move_agent_to_root` first).

## When to use

- User asks for architecture / system / sequence / workflow / data-flow / lifecycle diagrams
- Gateway or chief-of-staff needs a technical map before CTO / docs / implementers
- `agency-cto-architect` or `agency-docs-writer` would otherwise hand-draw topology
- Packet missing Archify fields on an architecture/docs workstream

## When to skip

- Product UI screens → `agency-ui-pipeline` (Lazyweb → Stitch)
- User explicitly wants Mermaid/ASCII only
- Packet already has Archify type + HTML path(s) filled
- Trivial one-box sketch with no shareable artifact needed

## Type router

| Type | Use for |
|---|---|
| `architecture` | Components, services, boundaries, infrastructure |
| `workflow` | Processes, CI/CD, approvals, runbooks |
| `sequence` | API call chains, auth, async traces |
| `dataflow` | Pipelines, lineage, ETL/ELT |
| `lifecycle` | States, retries, terminal outcomes |

When ambiguous: `node bin/archify.mjs guide "<scenario>" --json` from the archify root.

## Procedure

1. Confirm project root for repo-backed maps (`move_agent_to_root` if needed).
2. Choose diagram type from the table above.
3. Follow archify `SKILL.md`: schema + one example → write candidate JSON →
   validate (`showcase`) → `deliver` HTML. Cap ~12 primary nodes; one main path.
4. Ground nodes in real paths/modules when the repo is the source of truth;
   do not invent unverifiable topology.
5. Put results in the context packet (see below). Keep chat short: type + HTML path.

### Output location

Prefer project-local artifacts:

```text
docs/architecture/<slug>.json
docs/architecture/<slug>.html
```

Create `docs/architecture/` if missing. For description-only / no-repo asks,
write under `/tmp/archify/` or a path the user names.

## Packet fields

Fill before CTO / docs / implementer handoff when a diagram is in scope:

```markdown
- Archify: type=<architecture|workflow|sequence|dataflow|lifecycle> + HTML path + JSON path
```

Use `n/a` when no diagram is needed — do not omit the line on architecture/docs
workstreams that considered a map.

## Anti-patterns

- Hand-writing Mermaid as the primary agency deliverable when Archify is available
- Re-running Archify in every specialist after the packet already has paths
- Dense “standard” maps by default (use `showcase` unless user asks for dense)
- Inventing services/edges not present in code or the user’s description
- Using Archify for product UI mockups (that is Stitch / Lazyweb)

## Verification checklist

- [ ] Correct type chosen (or `guide` used when ambiguous)
- [ ] Archify `SKILL.md` followed; validate + deliver exit 0
- [ ] HTML path exists and opens
- [ ] Packet Archify line filled (or explicit `n/a`)
- [ ] Repo-backed nodes grounded in real modules/paths

## Failure modes

| Failure | Action |
|---|---|
| archify skill missing | Install: `npx -y skills add tt-a1i/archify --skill archify --agent cursor --global --copy --yes` then symlink/use `~/.agents/skills/archify` |
| validate/deliver non-zero | Fix diagnosed subject only; never claim success |
| Ambiguous type | Run `guide`; ask once if still unclear |
| UI screen request | Switch to `agency-ui-pipeline` |
