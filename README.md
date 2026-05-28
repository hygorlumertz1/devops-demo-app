# DevOps Demo App

Aplicação web estática demonstrativa para o projeto da disciplina **DevOps na Prática — PUCRS 2026**.

## Estrutura

```
projeto-devops/
├── .github/workflows/ci.yml   # Pipeline de CI/CD
├── src/                       # Código-fonte da aplicação
│   ├── index.html
│   ├── style.css
│   └── script.js
├── terraform/                 # Infraestrutura como Código
│   ├── provider.tf
│   ├── variables.tf
│   ├── main.tf
│   └── outputs.tf
├── tests/                     # Testes automatizados
│   └── theme.test.js
└── package.json
```

## Pipeline CI/CD

O pipeline executa automaticamente a cada push:

1. **Lint** — valida HTML, CSS e JavaScript
2. **Test** — executa testes com Jest
3. **Build** — gera artefato em `dist/`
4. **Deploy** — publica no GitHub Pages (branch `main`)

## Infraestrutura (Terraform)

Provisiona na AWS:
- **S3 Bucket** com versionamento e acesso bloqueado publicamente
- **CloudFront Distribution** com HTTPS e OAC
- **Política IAM** restrita ao CloudFront

### Uso local com LocalStack

```bash
cd terraform
# Inicializar
terraform init
# Validar
terraform validate
# Planejar
terraform plan
# Aplicar
terraform apply
```

## Testes

```bash
npm ci
npm test
```
