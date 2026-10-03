# Despliegue de ambientes DEV y QA con Terraform

Infraestructura como código con Terraform y Docker que levanta dos ambientes (DEV y QA). Cada uno tiene una arquitectura de 3 capas: Frontend (nginx + `index.html`), Backend (Node.js + `index.js`) y Base de datos (PostgreSQL).

Autor: <tu-nombre>

## Arquitectura

| Ambiente | Componente | Contenedor | Puerto (host:contenedor) |
|---|---|---|---|
| DEV | Frontend (nginx) | web-dev | 4001:80 |
| DEV | Backend (Node) | api-dev | 4002:3000 |
| DEV | PostgreSQL | bd-dev | 4003:5432 |
| QA | Frontend (nginx) | web-qa | 5001:80 |
| QA | Backend (Node) | api-qa | 5002:3000 |
| QA | PostgreSQL | bd-qa | 5003:5432 |

Flujo en cada ambiente: Frontend → Backend → Base de datos. Cada ambiente usa su propia red Docker (`net-dev` y `net-qa`), por lo que el backend de DEV solo se conecta a la base de datos de DEV, y lo mismo en QA.

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

Escribir `yes` cuando Terraform lo solicite. La primera vez tarda unos minutos porque construye las imágenes y descarga PostgreSQL.

> Por defecto el proyecto está configurado para Docker Desktop en Windows (`npipe:////./pipe/docker_engine`). En Linux o macOS, usar:
> `terraform apply -var="docker_host=unix:///var/run/docker.sock"`

### 3. Verificar

```bash
docker ps
```

Deben aparecer 6 contenedores: `web-dev`, `api-dev`, `bd-dev`, `web-qa`, `api-qa` y `bd-qa`.

Abrir en el navegador:

- DEV: http://localhost:4001
- QA: http://localhost:5001

Cada página muestra el ambiente y la hora de PostgreSQL, lo que confirma la conexión Frontend → Backend → BD.

API de cada ambiente:

- DEV: http://localhost:4002/api/info
- QA: http://localhost:5002/api/info

### 4. Destruir los ambientes

```bash
terraform destroy
```

Escribir `yes` para confirmar.

## Estructura del proyecto

```
├── frontend/     index.html + Dockerfile (nginx)
├── backend/      index.js + package.json + Dockerfile (node)
└── terraform/    configuración principal y módulo reutilizable "environment"
```

El módulo `terraform/modules/environment` se instancia dos veces (`dev` y `qa`) con distintos nombres y puertos, evitando duplicar código.

## Convención de commits

Se usa Conventional Commits: `feat`, `fix`, `docs`, `chore`, etc.