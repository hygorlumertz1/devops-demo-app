# ─── Stage de build ───────────────────────────────────────────────────────────
FROM node:20-alpine AS builder

WORKDIR /app

# Instala dependências (aproveita cache quando package.json não muda)
COPY package*.json ./
RUN npm ci

# Copia e valida o código-fonte
COPY . .
RUN npm run lint && npm test

# Copia os arquivos do site para dist/
RUN mkdir -p dist && cp -r src/* dist/

# ─── Stage de produção ────────────────────────────────────────────────────────
FROM nginx:1.27-alpine AS production

# Cria usuário não-root para segurança
RUN addgroup -g 1001 -S appgroup \
 && adduser  -u 1001 -S appuser -G appgroup

# Configuração customizada do nginx
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Copia apenas os arquivos estáticos do stage builder
COPY --from=builder /app/dist /usr/share/nginx/html

# Ajusta permissões para execução sem root
RUN chown -R appuser:appgroup /usr/share/nginx/html \
 && chown -R appuser:appgroup /var/cache/nginx \
 && chown -R appuser:appgroup /var/log/nginx \
 && touch /var/run/nginx.pid \
 && chown appuser:appgroup /var/run/nginx.pid

USER appuser

EXPOSE 8080

# Verifica saúde do container a cada 30s
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
    CMD wget --no-verbose --tries=1 --spider http://localhost:8080/health || exit 1

CMD ["nginx", "-g", "daemon off;"]
