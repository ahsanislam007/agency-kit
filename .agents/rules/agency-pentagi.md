---
description: Use agency-pentagi for authorized autonomous penetration testing (PentAGI)
alwaysApply: true
---

# Agency PentAGI (all projects)

When the user asks for **PentAGI**, **autonomous pentest**, **red-team agents**, or **authorized penetration testing** via a self-hosted multi-agent stack (nmap/Metasploit/sqlmap orchestration):

1. Route via `agency-project-gateway` first when the ask is substantive agency/repo work.
2. Load skill **`agency-pentagi`** (`~/.agents/skills/agency-pentagi/SKILL.md`).
3. Runtime clone: `$PENTAGI_HOME` (default `$HOME/Projects/pentagi`; Docker stack — not vendored into the skill).
4. **Authorized targets only** — require a `PentAGI:` Scope line (target + permission). Refuse unauthorized scanning, credential theft, malware packaging, and exploit PoCs against third parties.
5. Pair findings / client deliverables with `agency-qa-security`.

**Not this skill:** static RE → `agency-reverse-engineer-anything` / `agency-android-reverse-engineering`; mobile E2E → `agency-maestro-testing`.
