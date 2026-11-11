# Agency Kit — AI Agent Skills for Cursor, Claude Code & Multi-Agent Teams

**Agency Kit** is an open-source **AI agent skills** pack and multi-agent operating system for **Cursor**, **Claude Code**, Codex, Gemini, and other `SKILL.md`-compatible coding agents.

Use it when you want a **routed agency workflow**—not another dump of thousands of unrelated skills. A prime **project gateway** builds a context packet, runs a real **UI design pipeline** (research → screen design → React catalog supply), enforces product **motion**, then spawns specialist agents for Android/KMP/iOS, web, QA, architecture, docs, and authorized security work.

## Why Agency Kit

| Problem | Agency Kit approach |
|---------|---------------------|
| Agents freestyle every chat | `agency-project-gateway` + shared rules |
| Flat skill catalogs, no team | 28 specialist agents + skills that call each other |
| Static AI UI | Lazyweb → Stitch → 21st + `agency-rich-ui` motion |
| Mobile/web E2E left as homework | Maestro + Playwright setup skills |
| Skills glued to one author’s machine | Portable paths, MIT, install scripts |

## Who this is for

Built for people who **ship product** with AI coding agents.

| You are… | You get… |
|----------|----------|
| **Solo / indie product builders** | One gateway that routes build, UI, test, and docs |
| **Android / KMP / iOS developers** | App scaffold conventions, Maestro setup, Compose/SwiftUI motion |
| **React / Next.js / Tailwind developers** | Design → implement path, 21st catalog supply, marketing + product motion |
| **Small agency / studio leads** | Shared Cursor/Claude skills so the “team” behaves the same on every client repo |
| **Tech leads / founders with many repos** | Per-project + global install for consistent agent rules |
| **Security-minded builders (authorized only)** | Reverse-engineering / APK / PentAGI lanes with scope gates |

**Skip this** if you only want a random skill buffet, never ship UI/mobile, or won’t set up the MCPs the pipelines use ([MCP prerequisites](docs/mcp-prerequisites.md)).

## Features

- **Multi-agent orchestration** — gateway, context packet, token budget, Compound Engineering bridge  
- **Product UI pipeline** — design research → Stitch screens → 21st.dev React supply  
- **Rich UI motion** — mandatory enter/exit, press, scroll-aware motion on product screens  
- **Mobile & web testing** — Maestro, agent-device, Playwright Test + MCP  
- **Architecture maps** — Archify-backed system / sequence / data-flow docs  
- **Authorized security** — RE, Android RE, PentAGI (own systems / written permission only)  
- **Cross-IDE** — sync to `.cursor/`, `.claude/`, and agent home skill dirs  

## Install AI agent skills

### Add to a project (Cursor / Claude Code)

```bash
git clone https://github.com/ahsanislam007/agency-kit.git
bash agency-kit/install.sh /path/to/your/project
```

Adds `AGENTS.md`, `CLAUDE.md`, `GEMINI.md`, and `.agents/` when missing, then runs `sync.sh`.

### Install skills globally

```bash
cd agency-kit
AGENTS_SYNC_DRY_RUN=1 bash .agents/sync.sh --global   # preview
bash install-global.sh
```

Works with **Cursor skills**, **Claude Code skills**, and other agents that load `SKILL.md` from project or home directories.

## What’s included

| Area | Skills / agents (examples) |
|------|----------------------------|
| Orchestration | `agency-project-gateway`, `agency-context-packet`, `agency-token-budget`, `agency-compound-engineering` |
| Design / UI | `agency-ui-pipeline`, `agency-rich-ui`, `agency-web-craft`, `agency-21st`, `stitch-design`, `21st-*` |
| Build | `agency-app-architecture`, `ponytail*`, platform agents (Android, iOS, KMP, web, backend) |
| Test | `agency-mobile-test-setup`, `agency-maestro-testing`, `agency-web-test-setup`, `agency-playwright-testing` |
| Arch / research | `agency-archify`, `agency-agent-reach`, `agency-designlang` |
| Security (authorized) | `agency-reverse-engineer-anything`, `agency-android-reverse-engineering`, `agency-pentagi` |

Skill index: [docs/scorecard.md](docs/scorecard.md). MCP setup: [docs/mcp-prerequisites.md](docs/mcp-prerequisites.md).

## How the multi-agent flow works

```text
User ask
  → agency-project-gateway (triage + context packet)
      → UI? agency-ui-pipeline + agency-rich-ui
      → Spawn agency-* specialists (Task / subagents)
      → Optional: Compound Engineering loop (ce-* / /lfg)
```

## FAQ

**Is this a Cursor skills repo?**  
Yes. After `install.sh` or `sync.sh`, skills land under `.cursor/skills` (and Claude’s `.claude/skills`).

**Does it work with Claude Code?**  
Yes. Same `.agents/` source; `CLAUDE.md` points at `AGENTS.md`.

**How is this different from awesome-agent-skills catalogs?**  
Those are large libraries of standalone playbooks. Agency Kit is a **routed team**—gateway first, then specialists—with a fixed UI and test operating model.

**Do I need every MCP?**  
Only for the lanes you use. See [docs/mcp-prerequisites.md](docs/mcp-prerequisites.md).

## License

MIT — see [LICENSE](LICENSE). Some skill folders carry their own LICENSE / DISCLAIMER (RE, Maestro, PentAGI).

## Privacy

No personal machine paths, client codenames, or freelance/career private data in the public tree. See [docs/privacy-audit.md](docs/privacy-audit.md).
