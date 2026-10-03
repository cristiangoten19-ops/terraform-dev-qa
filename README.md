# Despliegue de ambientes DEV y QA con Terraform

Infraestructura como código con Terraform y Docker que levanta dos ambientes (DEV y QA). Cada uno tiene una arquitectura de 3 capas: Frontend (nginx + `index.html`), Backend (Node.js + `index.js`) y Base de datos (PostgreSQL).

Autor: Cristian

## Arquitectura

| Ambiente | Componente | Contenedor | Puerto (host:contenedor) |
|---|---|---|---|
| DEV | Frontend (nginx) | web-dev | 4001:80 |
| DEV | Backend (Node) | api-dev | 4002:3000 |
| DEV | PostgreSQL | bd-dev | 4003:5432 |
| QA | Frontend (nginx) | web-qa | 5001:80 |
| QA | Backend (Node) | api-qa | 5002:3000 |
| QA | PostgreSQL | bd-qa | 5003:5432 |


## Requisitos

- Git
- Docker Desktop (debe estar en ejecución)
- Terraform

Verificar la instalación:

```bash
git --version
docker --version
terraform --version
```

## Instrucciones desde cero

### 1. Clonar el proyecto

```bash
git clone https://github.com/cristiangoten19-ops/terraform-dev-qa.git
cd terraform-dev-qa
```

### 2. Desplegar los ambientes

```bash
cd terraform
terraform init
terraform validate
terraform plan
terraform apply
```



### 3. Verificar

```bash
docker ps
```

Deben aparecer 6 contenedores: `web-dev`, `api-dev`, `bd-dev`, `web-qa`, `api-qa` y `bd-qa`.

Abrir en el navegador:

- DEV: http://localhost:4001
- QA: http://localhost:5001



API de cada ambiente:

- DEV: http://localhost:4002/api/info
- QA: http://localhost:5002/api/info

### 4. Destruir los ambientes

```bash
terraform destroy
```


## Estructura del proyecto

```
├── frontend/     index.html + Dockerfile (nginx)
├── backend/      index.js + package.json + Dockerfile (node)
└── terraform/    configuración principal y módulo reutilizable "environment"
```

## Convención de commits

Se usa Conventional Commits: `feat`, `fix`, `docs`, `chore`, etc.