---
description: Prime orchestrator — agency-project-gateway auto-triggers for any agency-team work and may spawn specialists
alwaysApply: true
---

# Agency prime: project-gateway

## Auto-trigger (parent agent MUST)

On any request that matches **agency-team work** below, launch `agency-project-gateway` first via `Task` (`subagent_type: agency-project-gateway`) **before** editing, designing, or spawning other `agency-*` agents. Agents without subagents run the `agency-project-gateway` skill checklist inline instead.

**Triggers (any of):** product/feature build, UI/UX/design, brand, Figma, web/mobile/KMP implement, backend/API/cloud, architecture, DevOps/CI, QA/security, **design QA / visual audit**, **authorized reverse engineering**, **authorized pentest / PentAGI**, **mobile testing / agentic E2E / Maestro / agent-device setup**, **web testing / Playwright / browser E2E setup**, **21st.dev / Magic MCP React catalog install**, docs, product/PM, research, growth/marketing, revenue, sales enablement, customer success, finance/ops, data/analytics, AI/automation, multi-agent agency routing, Lazyweb/Stitch/rich-ui/21st pipelines.

**Do NOT skip** by calling specialists directly — gateway routes them.

## Skip only

- No git repo / home / empty-window general chat
- Trivial Q&A with no code, design, or agency routing

## Gateway authority

Gateway **owns** orchestration: builds `agency-context-packet`, runs `agency-ui-pipeline` (Lazyweb → Stitch) + `agency-rich-ui` for product UI, loads **`agency-21st`** (21st MCP catalog) for React/Tailwind/shadcn implement supply after design, runs `agency-archify` for architecture / sequence / workflow / data-flow / lifecycle maps, loads `agency-agent-reach` for live web/YouTube/GitHub/RSS/Exa (and optional social) research beyond Lazyweb, loads `agency-app-architecture` for new Android/KMP app bootstrap (MVVM+MVI + `build-logic` conventions), loads `agency-mobile-test-setup` (+ `agency-maestro-testing` for flow authoring) for mobile Maestro + agent-device / agentic E2E setup (discover appId per repo), loads `agency-web-test-setup` (+ `agency-playwright-testing` for spec authoring) for web Playwright + Playwright MCP / agentic browser E2E setup (discover baseURL per repo; chromium smoke default), loads `agency-design-qa-report` for design QA / Figma-vs-app reports, loads `agency-reverse-engineer-anything` (+ `agency-android-reverse-engineering`) for authorized shipped-artifact RE, loads **`agency-pentagi` for authorized autonomous pentest**, loads **`agency-feature-docs` as a side skill after user-facing feature impl** (README + user guide + screenshots), loads **`agency-compound-engineering`** to compose Compound Engineering (`ce-*` / `/lfg`) for brainstorm→plan→work→compound without replacing gateway or Task spawn. Multi-step → `agency-chief-of-staff` after gateway triage.

## Team (gateway may spawn)

| Lane | Agents |
|------|--------|
| Plan | `agency-chief-of-staff`, `agency-product-manager`, `agency-cto-architect`, `agency-user-researcher` |
| Design | `agency-ui-ux-designer`, `agency-brand-designer`, `agency-figma-design-system`, `agency-figma-to-kmp-ui`, `agency-marketing-growth` |
| Build | `agency-frontend-web-engineer`, `agency-android-developer`, `agency-ios-developer`, `agency-kmp-engineer`, `agency-project-engineer`, `agency-backend-engineer`, `agency-backend-cloud`, `agency-automation-ai-integrations`, `agency-build-governance` |
| Ship | `agency-devops-sre`, `agency-qa-security`, `agency-docs-writer` |
| Biz | `agency-revenue-strategist`, `agency-sales-enablement`, `agency-customer-success`, `agency-data-analyst`, `agency-finance-ops` |

Canonical UI agent: `agency-ui-ux-designer` (never `agency-u-ux-designer`). Skills gateway loads: `agency-context-packet`, `agency-ui-pipeline`, `agency-rich-ui`, `agency-21st`, `agency-web-craft`, `agency-designlang`, `agency-archify`, `agency-agent-reach`, `agency-app-architecture`, `agency-mobile-test-setup`, `agency-maestro-testing`, `agency-web-test-setup`, `agency-playwright-testing`, `agency-design-qa-report`, `agency-feature-docs`, `agency-reverse-engineer-anything`, `agency-android-reverse-engineering`, `agency-pentagi`, `agency-compound-engineering`, `agency-token-budget`.
