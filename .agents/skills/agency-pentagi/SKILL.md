---
name: agency-pentagi
description: >
  Agency-global autonomous penetration testing via PentAGI (vxcontrol/pentagi).
  Use when the user wants authorized pentests, red-team agent flows, nmap/Metasploit/
  sqlmap orchestration through a self-hosted multi-agent stack, or PentAGI install/
  API/UI ops. Prefer for client-authorized security assessments on own infra.
  Pair findings with agency-qa-security. Skip for static RE (use
  agency-reverse-engineer-anything / agency-android-reverse-engineering) and for
  Maestro/E2E (agency-maestro-testing). Triggers: pentAGI, PentAGI, autonomous
  pentest, red team agents, authorized penetration test, security agent stack.
disable-model-invocation: false
metadata:
  version: "1"
  upstream: "vxcontrol/pentagi"
  runtime: "$PENTAGI_HOME"
---

# Agency PentAGI

**Agency kit skill** — installed for every agent (Cursor, Claude Code, Codex, Gemini, …) at `~/.agents/skills/agency-pentagi`.

Upstream: [vxcontrol/pentagi](https://github.com/vxcontrol/pentagi) (MIT + EULA; self-hosted autonomous pentest multi-agent system).

Runtime clone (not vendored into this skill): `$PENTAGI_HOME` (default `$HOME/Projects/pentagi`).

## Agency wiring (read first)

| Layer | Skill / tool |
|-------|----------------|
| Route | `agency-project-gateway` first on substantive repo / agency work |
| This skill | Install, start, scope, and drive PentAGI (UI / REST / GraphQL) |
| Static RE / APK | `agency-reverse-engineer-anything` / `agency-android-reverse-engineering` |
| Findings / test plan | `agency-qa-security` |
| Live mobile UI automation | `user-maestro` MCP (not this skill) |

1. **Authorized use only** — own systems, client-written authorization, or lab VMs you control. Refuse unauthorized scanning, credential theft, malware packaging, ransomware, or exploit PoCs against third parties.
2. Require a **Scope:** line before any active test: `target=… | permission=… | non-goals=… | out=<report path>`.
3. Do not silently install Docker or run the interactive installer without user approval. Report missing deps; ask before `brew install --cask docker` or `./installer`.
4. Prefer PentAGI’s sandboxed Docker workers — never bind-mount the host Docker socket unless the user explicitly accepts that blast radius (see upstream README).
5. Packet line: `PentAGI: target=<host|cidr|url> | permission=<yes|path-to-auth> | ui=https://localhost:8443 | status=…`

## What PentAGI is

Self-hosted multi-agent penetration testing platform. You describe a target and goal in plain language; specialized AI agents plan and run 20+ tools (nmap, Metasploit, sqlmap, …) inside isolated Docker sandboxes, store memory in PostgreSQL/pgvector, and produce reports. Web UI default: `https://localhost:8443`.

**Not** a substitute for:

- Source-repo architecture review (read the code)
- Static binary/APK RE (REA / Android RE skills)
- Deterministic mobile E2E (Maestro)

## Prerequisites

| Requirement | Notes |
|-------------|--------|
| Docker Desktop (or Docker Engine + Compose) | **Required** — not detected → stop and ask user to install |
| 2+ vCPU, 4GB+ RAM, 20GB disk | Upstream minimum |
| LLM provider key or local Ollama/vLLM | OpenAI, Anthropic, Gemini, Bedrock, DeepSeek, … |
| Network | Pull images + reach target under test |

Check local readiness:

```bash
bash "$HOME/.agents/skills/agency-pentagi/scripts/check-deps.sh"
```

## Install / start (runtime)

Canonical clone path: `$PENTAGI_HOME` (default `$HOME/Projects/pentagi`).

### Option A — Interactive installer (recommended)

macOS Apple Silicon (`arm64`):

```bash
mkdir -p "$HOME/Projects/pentagi-install" && cd "$HOME/Projects/pentagi-install"
curl -fsSL -o installer.zip https://pentagi.com/downloads/darwin/arm64/installer-latest.zip
unzip -o installer.zip
./installer
```

Intel Mac: use `darwin/amd64` instead of `darwin/arm64`.

Installer walks Docker checks, `.env`, LLM providers, search engines, credentials, and `docker compose` bring-up. Accept upstream EULA; change default admin password on first login.

### Option B — Compose from cloned repo

```bash
export PENTAGI_HOME="${PENTAGI_HOME:-$HOME/Projects/pentagi}"
cd "$PENTAGI_HOME"
cp .env.example .env   # if present; otherwise use installer-generated .env
# Fill LLM_* / provider keys — never commit secrets
docker compose up -d
```

Guides: upstream [Installing and Configuring PentAGI](https://github.com/vxcontrol/pentagi/blob/master/examples/guides/installation_configuration.md).

### First login

- URL: `https://localhost:8443`
- Default: `admin@pentagi.com` / `admin` — **change immediately**
- API docs: `https://localhost:8443/api/v1/swagger/index.html`
- GraphQL playground: `https://localhost:8443/api/v1/graphql/playground`

Bearer tokens: Settings → PentAGI API (after login).

## Agent workflow

1. **Confirm authorization** — written scope from user; refuse if vague (“scan this company”).
2. **`check-deps.sh`** — Docker + clone present.
3. **Ensure stack is up** — `docker compose ps` in runtime dir, or UI reachable on `:8443`.
4. **Create / run a flow** — via UI or REST/GraphQL with user-supplied Bearer token (never invent credentials).
5. **Collect report** — Markdown/PDF from UI; summarize findings for the user; hand off severity triage to `agency-qa-security` when shipping a client deliverable.
6. **Tear down** when asked — `docker compose down` (do not delete volumes unless user requests).

API sketch (after user provides token + base URL):

```bash
# List flows (example — adjust to live OpenAPI)
curl -sS -H "Authorization: Bearer $PENTAGI_TOKEN" \
  "https://localhost:8443/api/v1/flows"
```

Prefer upstream Swagger for exact paths; do not invent endpoints.

## Authorization & refusal

**Allowed:** systems the user owns; labs; clients with explicit written permission; CTF/lab VMs they provisioned.

**Refuse:** unauthorized third-party hosts; “find exploits for competitor X”; credential stuffing; packaging malware; anything that violates PentAGI EULA or local law.

When refusing: few short sentences; no partial exploit steps.

Details: [references/authorization.md](references/authorization.md).

## Install / ops reference

See [references/install.md](references/install.md) for Docker missing, macOS Gatekeeper on installer, multi-instance `TENANT_ID`, and worker-node isolation notes.

## Overlap map

| Ask | Route |
|-----|--------|
| Autonomous authorized pentest | **This skill** |
| Decompile APK / binary | `agency-reverse-engineer-anything` (+ Android RE) |
| App UI E2E / smoke | `agency-maestro-testing` / `agency-mobile-test-setup` |
| Security review of *our* code diff | `agency-qa-security` / Security Review subagent |
