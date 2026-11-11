# Privacy

This kit is meant to be safe to clone into other people’s machines and client repos.

## What we keep out of the public tree

- Personal machine paths (hardcoded home directories)
- Private product / package identifiers from the author’s other apps
- Client or internal project codenames
- Personal freelance / career / billing material
- Secrets, webhooks, and env files

## What is fine to ship

- Portable env vars (`$HOME`, `$PENTAGI_HOME`, etc.)
- Public upstream tool names the skills depend on (documented in [mcp-prerequisites.md](mcp-prerequisites.md))
- An optional public demo URL for motion patterns (not a required brand)

## Check yourself before forking further

```bash
rg -n '/Users/[^/]+/' .agents
```

If that surfaces a personal home path, replace it with `$HOME` or a documented env var before you redistribute.
