#!/usr/bin/env bash
# =============================================================================
# deploy.sh — Deploy da aplicação via Docker (produção)
# Uso: ./scripts/deploy.sh [IMAGE_TAG]
# Exemplo: ./scripts/deploy.sh sha-abc1234
#          ./scripts/deploy.sh latest
# =============================================================================

set -euo pipefail

IMAGE_TAG="${1:-latest}"
REGISTRY="ghcr.io/hygorlumertz1/devops-demo-app"
COMPOSE_FILE="docker-compose.prod.yml"

echo "==> [deploy] Iniciando deploy — imagem: ${REGISTRY}:${IMAGE_TAG}"

# 1. Autentica no registry (requer GITHUB_TOKEN no ambiente)
if [[ -n "${GITHUB_TOKEN:-}" ]]; then
  echo "${GITHUB_TOKEN}" | docker login ghcr.io -u hygorlumertz1 --password-stdin
  echo "==> [deploy] Login no ghcr.io realizado"
fi

# 2. Baixa a imagem antes de parar o container atual (zero-downtime)
echo "==> [deploy] Baixando imagem ${REGISTRY}:${IMAGE_TAG}..."
docker pull "${REGISTRY}:${IMAGE_TAG}"

# 3. Sobe o novo container (substitui o anterior)
echo "==> [deploy] Subindo container..."
IMAGE_TAG="${IMAGE_TAG}" docker compose -f "${COMPOSE_FILE}" up -d --remove-orphans

# 4. Aguarda health check
echo "==> [deploy] Aguardando health check..."
sleep 10
if docker compose -f "${COMPOSE_FILE}" ps | grep -q "healthy"; then
  echo "==> [deploy] Container saudável. Deploy concluído com sucesso!"
else
  echo "==> [deploy] AVISO: health check ainda pendente — verifique com 'docker compose ps'"
fi

# 5. Remove imagens antigas não utilizadas
docker image prune -f --filter "label=project=devops-demo" 2>/dev/null || true

echo "==> [deploy] Feito! Site disponível em http://localhost"
