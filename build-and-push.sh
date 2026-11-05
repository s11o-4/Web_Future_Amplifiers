#!/usr/bin/env bash
#
# Build the Docker image and push it to your private registry.
#
# Usage:
#   ./build-and-push.sh [TAG]
#
# Examples:
#   ./build-and-push.sh                    # tag = latest
#   ./build-and-push.sh v1.2.3             # tag = v1.2.3
#
# Configure either by editing the variables below or by setting the
# corresponding environment variables (env vars take precedence).
#

set -euo pipefail

# ---------------------------------------------------------------------------
# Config (edit these or override via environment)
# ---------------------------------------------------------------------------
REGISTRY="${REGISTRY:-registry.example.com}"   # your private registry host
REPOSITORY="${REPOSITORY:-web}"                # repository/project path
IMAGE_NAME="${IMAGE_NAME:-future-amplifiers}"  # image name
TAG="${1:-${TAG:-latest}}"                     # image tag (arg or env)

IMAGE="${REGISTRY}/${REPOSITORY}/${IMAGE_NAME}:${TAG}"

echo "==> Building image: ${IMAGE}"
docker build \
  --tag "${IMAGE}" \
  .

echo "==> Pushing image: ${IMAGE}"
docker push "${IMAGE}"

echo ""
echo "Done. Image ${IMAGE} is available in your registry."
echo ""
echo "To deploy to Kubernetes, update the image in k8s/deployment.yaml (or use kustomize/helm), then run:"
echo "  kubectl apply -f k8s/namespace.yaml"
echo "  kubectl apply -f k8s/deployment.yaml -f k8s/service.yaml -f k8s/ingress.yaml"
