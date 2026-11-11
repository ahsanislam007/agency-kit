# PentAGI — install & ops (agency)

Canonical source: [vxcontrol/pentagi](https://github.com/vxcontrol/pentagi).  
Local clone: `$PENTAGI_HOME` (default `$HOME/Projects/pentagi`).

## Docker missing (macOS)

PentAGI requires Docker. If `check-deps.sh` reports `INSTALL_REQUIRED:docker`:

1. Ask the user before installing.
2. With approval: `brew install --cask docker` then open Docker Desktop and wait until the engine is running.
3. Re-run `check-deps.sh`.

Podman is supported upstream; prefer Docker Desktop unless the user asks for Podman.

## Interactive installer (macOS)

| Arch | URL |
|------|-----|
| Apple Silicon | `https://pentagi.com/downloads/darwin/arm64/installer-latest.zip` |
| Intel | `https://pentagi.com/downloads/darwin/amd64/installer-latest.zip` |

If Gatekeeper quarantines the binary, use only official pentagi.com links and follow upstream [installer troubleshooting](https://github.com/vxcontrol/pentagi/blob/master/backend/docs/installer/installer-troubleshooting.md).

Installer needs Docker socket access (Docker Desktop running). Prefer not adding the user to a Linux-style `docker` group on Mac — Desktop handles the socket.

## Compose from clone

```bash
cd "${PENTAGI_HOME:-$HOME/Projects/pentagi}"
docker compose up -d
docker compose ps
```

Optional stacks in repo: `docker-compose-observability.yml`, `docker-compose-langfuse.yml`, `docker-compose-graphiti.yml`.

Secrets live in `.env` — never commit. Rotate default admin password at first UI login (`https://localhost:8443`).

## After start

| Surface | URL |
|---------|-----|
| Web UI | `https://localhost:8443` |
| Swagger | `https://localhost:8443/api/v1/swagger/index.html` |
| GraphQL playground | `https://localhost:8443/api/v1/graphql/playground` |

Default login: `admin@pentagi.com` / `admin` → change immediately.

## Multi-instance

Upstream supports `TENANT_ID` for several instances — see README “Running Several Instances”.

## Worker isolation (production)

For stronger blast-radius control, use the upstream [Worker Node Setup](https://github.com/vxcontrol/pentagi/blob/master/examples/guides/worker_node.md) (separate worker node + dind TLS). Do not recommend mounting the host Docker socket for autonomous agents.

## Update clone

```bash
cd "${PENTAGI_HOME:-$HOME/Projects/pentagi}" && git pull --ff-only
```

Re-pull Docker images via installer maintenance or `docker compose pull && docker compose up -d` as appropriate.
