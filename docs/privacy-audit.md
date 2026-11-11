# Privacy audit (public release)

## Stripped / rewritten before publish

| Item | Action |
|------|--------|
| Absolute user home machine paths | Replaced with `$HOME` / `$PENTAGI_HOME` / `$MAESTRO_BIN` |
| Local marketing site clone path | Removed; optional public demo URL only |
| Private product package ids | Generic `com.example.agency.*` + neutral examples |
| Client / internal app codenames | Neutral wording |
| Freelance marketplace skills + routing | Excluded from this repo |
| Career profile / rates / webhooks | Never copied |

## Leak gate (must be empty on skill/agent/rule trees)

```bash
rg -n '/Users/mac|xeon360-hq|faremeter|proof-library|ahsanislam04|org_uid|Elara Heritage|Classmates|com\.xeon360|agency-upwork' .agents
```

## Allowlisted

- Optional public motion demo host for grain/reveal/progress patterns (not a forced brand)
- Upstream project names (PentAGI, Maestro, Playwright, 21st.dev)
