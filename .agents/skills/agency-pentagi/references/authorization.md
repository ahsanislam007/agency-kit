# PentAGI — authorization guardrails

## Required before any active test

Capture in the context packet:

```text
PentAGI: target=<ip|cidr|hostname|url> | permission=<user-stated ownership OR path to SoW/LOA> | non-goals=<…> | status=scoped
```

If `permission` is missing or vague, **stop** and ask. Do not “probe lightly.”

## Acceptable use (aligned with upstream EULA)

- Lawful penetration testing and research only
- Explicit permission from the network / system owner
- User is solely responsible for tasks given to AI agents
- Do not use against critical infrastructure without proper authorization and validation

## Hard refusals

- Scanning or attacking systems without authorization
- Credential theft, phishing kits, ransomware, malware packaging
- DRM cracks or unauthorized access tooling as the goal
- Exploit PoCs aimed at third parties outside an authorized engagement
- Binding host Docker socket to agents without an explicit user risk acceptance

## Safe defaults

- Prefer isolated lab / staging / user-owned IPs
- Prefer hardened dind-over-TLS for worker Docker (`DOCKER_INSIDE=true`) over host socket mounts
- Change default `admin@pentagi.com` / `admin` before real work
- Never commit `.env`, API keys, or Bearer tokens to git
- Do not log PII from target systems into chat beyond what the user asked for in a report summary
