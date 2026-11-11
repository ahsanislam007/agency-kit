# MCP & external prerequisites

Agency skills assume tools may already be installed. This kit does **not** vendor binaries or API keys.

| Capability | Typical setup | Used by |
|------------|---------------|---------|
| Lazyweb | Lazyweb MCP + skills | `agency-ui-pipeline` |
| Stitch | Stitch MCP (`user-stitch`) | `agency-ui-pipeline`, `stitch-design` |
| 21st.dev | 21st MCP + API key | `agency-21st`, `21st-*` |
| Maestro | Maestro CLI + MCP (`$HOME/.maestro/bin/maestro mcp`) | `agency-maestro-testing`, mobile setup |
| Playwright | `@playwright/mcp` + Playwright Test in project | `agency-playwright-testing`, web setup |
| Designlang | Designlang MCP | `agency-designlang` |
| Archify | Engine skill at `~/.agents/skills/archify` | `agency-archify` |
| Agent Reach | CLI / skill at `~/.agents/skills/agent-reach` | `agency-agent-reach` |
| Compound Engineering | Cursor plugin `compound-engineering` | `agency-compound-engineering` |
| PentAGI | Clone to `$PENTAGI_HOME` (default `$HOME/Projects/pentagi`) + Docker | `agency-pentagi` |
| Graphify | Optional `graphify-out/` in target repos | exploration rules |

Configure MCP servers in your IDE (Cursor: `~/.cursor/mcp.json`; Claude Code: `claude mcp add …`). Never commit secrets.
