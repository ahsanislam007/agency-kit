# Agency kit

Open-source **agency operating system** for AI coding agents (Cursor, Claude Code, Codex, Gemini, and friends).

Not another dump of 3,000 unrelated skills. This kit is a **routed multi-agent team**: gateway → context packet → specialists, with a real UI design pipeline (Lazyweb → Stitch → 21st), mandatory product motion, mobile/web E2E setup, architecture maps, and authorized security lanes.

## Who this is for

Built for people who ship **product** with AI coding agents—not for prompt tourists or flat skill collectors.

| You are… | You get… |
|----------|----------|
| **Solo / indie product builders** | One gateway that routes build, UI, test, and docs instead of babysitting every chat |
| **Android / KMP / iOS engineers** | App scaffold conventions, Maestro + agent-device setup, Compose/SwiftUI motion expectations |
| **React / Next / Tailwind frontend engineers** | Lazyweb→Stitch design path, 21st catalog supply, rich motion on marketing + product UI |
| **Small agency / studio leads** | Shared agents + skills so Cursor/Claude behave like a team (PM, design, FE/mobile, QA) across client repos |
| **Tech leads / founders with many repos** | Global install + per-project sync so every codebase gets the same operating rules |
| **Security-minded builders (authorized only)** | RE / APK / PentAGI lanes with scope gates—not casual hacking tips |

**Less ideal if** you only want a random `SKILL.md` buffet, never touch product UI/mobile, or refuse to install the MCP tools the pipelines assume (see [docs/mcp-prerequisites.md](docs/mcp-prerequisites.md)).

## Install

### Into a project

```bash
git clone https://github.com/ahsanislam007/agency-kit.git
bash agency-kit/install.sh /path/to/your/project
```

Adds `AGENTS.md`, `CLAUDE.md`, `GEMINI.md`, and `.agents/` when missing, then runs `sync.sh`.

### Machine-wide (skills / agents / rules)

```bash
cd agency-kit
AGENTS_SYNC_DRY_RUN=1 bash .agents/sync.sh --global   # preview
bash install-global.sh                                 # link
```

## What’s included

| Area | Examples |
|------|----------|
| Orchestration | `agency-project-gateway`, `agency-context-packet`, `agency-token-budget`, `agency-compound-engineering` |
| Design / UI | `agency-ui-pipeline`, `agency-rich-ui`, `agency-web-craft`, `agency-21st`, `stitch-design`, `21st-*` |
| Build | `agency-app-architecture`, `ponytail*`, platform agents |
| Test | `agency-mobile-test-setup`, `agency-maestro-testing`, `agency-web-test-setup`, `agency-playwright-testing` |
| Arch / research | `agency-archify`, `agency-agent-reach`, `agency-designlang` |
| Security (authorized) | `agency-reverse-engineer-anything`, `agency-android-reverse-engineering`, `agency-pentagi` |

Full index: [docs/scorecard.md](docs/scorecard.md). MCP setup: [docs/mcp-prerequisites.md](docs/mcp-prerequisites.md).

## Quick mental model

```text
User ask
  → agency-project-gateway (triage + packet)
      → UI? agency-ui-pipeline (Lazyweb → Stitch) + agency-rich-ui
      → Task spawn: agency-* specialists
      → Optional: Compound Engineering loop (ce-* / /lfg)
```

## License

MIT — see [LICENSE](LICENSE). Some vendored skill folders carry their own LICENSE / DISCLAIMER (RE, Maestro, PentAGI).

## Privacy

No personal machine paths, client codenames, or freelance/career private data in the public tree. See [docs/privacy-audit.md](docs/privacy-audit.md).
