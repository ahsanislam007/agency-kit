#!/usr/bin/env bash
# Machine-readable readiness check for agency-pentagi.
set -euo pipefail

CLONE="${PENTAGI_HOME:-$HOME/Projects/pentagi}"
ok=0

echo "agency-pentagi check-deps"
echo "CLONE=$CLONE"

if [[ -d "$CLONE/.git" ]] || [[ -f "$CLONE/docker-compose.yml" ]]; then
  echo "OK:clone"
else
  echo "INSTALL_REQUIRED:clone"
  echo "  hint: git clone https://github.com/vxcontrol/pentagi.git \"$CLONE\""
  ok=1
fi

if command -v docker >/dev/null 2>&1; then
  if docker info >/dev/null 2>&1; then
    echo "OK:docker"
  else
    echo "INSTALL_REQUIRED:docker-engine"
    echo "  hint: start Docker Desktop (or the Docker daemon)"
    ok=1
  fi
else
  echo "INSTALL_REQUIRED:docker"
  echo "  hint: brew install --cask docker  # ask user first"
  ok=1
fi

if command -v docker >/dev/null 2>&1 && docker compose version >/dev/null 2>&1; then
  echo "OK:compose"
elif command -v docker-compose >/dev/null 2>&1; then
  echo "OK:compose-v1"
else
  echo "INSTALL_REQUIRED:compose"
  ok=1
fi

# Optional: UI already up
if command -v curl >/dev/null 2>&1; then
  if curl -sk --connect-timeout 2 "https://localhost:8443" -o /dev/null; then
    echo "OK:ui:https://localhost:8443"
  else
    echo "OPTIONAL:ui_down"
  fi
fi

if [[ "$ok" -eq 0 ]]; then
  echo "STATUS:ready"
  exit 0
fi
echo "STATUS:blocked"
exit 1
