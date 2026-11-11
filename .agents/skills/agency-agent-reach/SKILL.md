---
name: agency-agent-reach
description: >
  Agency SOP for internet research via Agent Reach (web/YouTube/GitHub/RSS/Exa
  and optional login channels). Use when gateway or specialists need to fetch
  live web/social/video/repo evidence beyond Lazyweb product screens, when the
  user asks to read a URL / YouTube / GitHub / RSS / search the open web, or
  when packet AgentReach fields are empty before research-heavy handoff.
  Do NOT use for product UI mockups (agency-ui-pipeline), architecture diagrams
  (agency-archify), or when Lazyweb already covers the ask.
disable-model-invocation: false
---

# Agency Agent Reach: internet eyes for agents

Canonical agency path for **live web / social / video / repo research** outside
Lazyweb’s product-screen corpus. Routers load this when research needs upstream
CLIs; specialists follow the engine skill — do not invent scrapers.

## Engine

Underlying runtime: `agent-reach` CLI + skill at `~/.agents/skills/agent-reach`
(read directly by Cursor, Codex, Gemini CLI; Claude Code gets a copy/link in `~/.claude/skills`).

Upstream: https://github.com/Panniantong/agent-reach

1. Prefer English skill: `AGENT_REACH_LANG=en`.
2. Read `~/.agents/skills/agent-reach/SKILL.md` and call
   **upstream tools directly** (Jina, `gh`, `yt-dlp`, mcporter/Exa, etc.).
   Agent Reach is selector / installer / doctor / router — not a wrapper API.
3. Health: `agent-reach doctor`

## Repo gate

Works in **any** agent session (global skill). Prefer a project root for
repo-backed asks (`move_agent_to_root`). Safe for home/no-repo when the user
only wants URL/video/search research.

## When to use

- Read arbitrary URLs, YouTube transcripts, GitHub repos/issues, RSS feeds
- Open-web semantic search (Exa via mcporter) when docs/MCP search are thin
- Social / optional channels **only after** user asked to configure them
- Gateway / research / growth / sales research needing live evidence

## When to skip

- Product UI screens / flows → `agency-ui-pipeline` (Lazyweb → Stitch)
- Architecture diagrams → `agency-archify`
- Lazyweb already answers (product screens, paywalls, experiments)
- Trivial Q&A with no external fetch needed

## Zero-config channels (default)

After `agent-reach install --env=auto --system` (user-approved):

| Need | Typical upstream |
|---|---|
| Web page → markdown | `curl https://r.jina.ai/<URL>` |
| GitHub public | `gh repo view` / `gh issue list` … |
| YouTube captions / search | `yt-dlp` |
| RSS/Atom | feedparser / agent-reach channel docs |
| Web semantic search | Exa via `mcporter` |
| V2EX / Bilibili basic | see engine SKILL.md |

## Optional channels (ask first)

Twitter/X, Reddit, Facebook, Instagram, XiaoHongShu, LinkedIn full, Boss直聘,
Xueqiu, Xiaoyuzhou — need cookies / OpenCLI / keys. Present the menu; install
only what the user names (`agent-reach install --system --channels=...`).

Prefer secondary accounts for cookie/session platforms.

## Procedure

1. Confirm CLI: `command -v agent-reach` (PATH should include `~/.local/bin`).
2. If missing: follow https://raw.githubusercontent.com/Panniantong/agent-reach/main/docs/install.md
   — venv or pipx; then `AGENT_REACH_LANG=en agent-reach skill --install`. If an agent
   doesn't list it: `ln -sfn ~/.agents/skills/agent-reach ~/.<agent>/skills/agent-reach`
3. Run `agent-reach doctor`; fix only within install.md boundaries (no sudo
   unless user approved).
4. Read engine `SKILL.md`; call upstream tools for the ask.
5. Put short findings + tool used in the context packet (see below).

## Packet fields

```markdown
- AgentReach: used=<yes|no|n/a> + channels=<web|youtube|github|rss|exa|…> + notes=<1 line>
```

Use `n/a` when no live fetch was needed.

## Anti-patterns

- Cloning agent-reach or tools into a project workspace
- Running `install --system` without explicit user approval
- Scraping when Lazyweb/Stitch already covers product UI research
- Storing cookies outside `~/.agent-reach/` or echoing secrets into chat
- Treating agent-reach as an HTTP API wrapper instead of routing to upstream CLIs

## Verification checklist

- [ ] `agent-reach doctor` shows needed channels healthy (or user declined optionals)
- [ ] Engine skill installed (`~/.agents/skills/agent-reach`) and listed by the current agent
- [ ] Packet AgentReach line filled when research ran
- [ ] No project-dir pollution under the active repo

## Failure modes

| Failure | Action |
|---|---|
| CLI missing | Install per docs/install.md (Python ≥3.10); symlink `~/.local/bin/agent-reach` |
| Skill missing in an agent | `AGENT_REACH_LANG=en agent-reach skill --install`; link `~/.agents/skills/agent-reach` into that agent's skills dir |
| Channel ❌ in doctor | Follow doctor prescription; ask user for cookies/OpenCLI only if required |
| UI screen request | Switch to `agency-ui-pipeline` |
