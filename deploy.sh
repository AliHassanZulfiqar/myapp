#!/usr/bin/env bash
set -euo pipefail

IMAGE="ghcr.io/alihassanzulfiqar/myapp"
TAG="${1:-latest}"

echo "Pulling $IMAGE:$TAG"
docker pull "$IMAGE:$TAG"

echo "Replacing container"
docker rm -f myapp 2>/dev/null || true
docker run -d --name myapp -p 8000:8000 "$IMAGE:$TAG"

echo "Health check"
for i in 1 2 3 4 5; do
  if curl -fsS http://localhost:8000 >/dev/null; then
    echo "OK: myapp is serving $TAG"
    exit 0
  fi
  sleep 1
done
echo "FAILED: myapp did not respond. Logs:"
docker logs myapp
exit 1
