#!/usr/bin/env bash
# =============================================================================
# rollback.sh — Reverte para uma versão anterior da imagem Docker
# Uso: ./scripts/rollback.sh <IMAGE_TAG>
# Exemplo: ./scripts/rollback.sh sha-abc1234
# =============================================================================

set -euo pipefail

IMAGE_TAG="${1:-}"

if [[ -z "${IMAGE_TAG}" ]]; then
  echo "Erro: informe a tag da imagem para rollback."
  echo "Uso: ./scripts/rollback.sh <IMAGE_TAG>"
  echo ""
  echo "Tags disponíveis no registry:"
  echo "  ghcr.io/hygorlumertz1/devops-demo-app"
  exit 1
fi

echo "==> [rollback] Revertendo para imagem tag: ${IMAGE_TAG}"

IMAGE_TAG="${IMAGE_TAG}" docker compose -f docker-compose.prod.yml up -d --remove-orphans

echo "==> [rollback] Rollback concluído para: ${IMAGE_TAG}"
