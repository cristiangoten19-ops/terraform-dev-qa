terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0"
    }
  }
}

resource "docker_network" "net" {
  name = "net-${var.env}"
}

resource "docker_image" "db" {
  name         = "postgres:16-alpine"
  keep_locally = true
}

resource "docker_image" "api" {
  name = "api-${var.env}:latest"
  build {
    context = "${var.root_path}/backend"
  }
}

resource "docker_image" "web" {
  name = "web-${var.env}:latest"
  build {
    context = "${var.root_path}/frontend"
  }
}

resource "docker_container" "db" {
  name    = "bd-${var.env}"
  image   = docker_image.db.image_id
  restart = "unless-stopped"
  env = [
    "POSTGRES_USER=${var.db_user}",
    "POSTGRES_PASSWORD=${var.db_password}",
    "POSTGRES_DB=${var.db_name}",
  ]
  ports {
    internal = 5432
    external = var.db_port
  }
  networks_advanced {
    name = docker_network.net.name
  }
}

resource "docker_container" "api" {
  name       = "api-${var.env}"
  image      = docker_image.api.image_id
  restart    = "unless-stopped"
  depends_on = [docker_container.db]
  env = [
    "APP_ENV=${var.env}",
    "DB_HOST=bd-${var.env}",
    "DB_PORT=5432",
    "DB_USER=${var.db_user}",
    "DB_PASSWORD=${var.db_password}",
    "DB_NAME=${var.db_name}",
  ]
  ports {
    internal = 3000
    external = var.api_port
  }
  networks_advanced {
    name = docker_network.net.name
  }
}

resource "docker_container" "web" {
  name       = "web-${var.env}"
  image      = docker_image.web.image_id
  restart    = "unless-stopped"
  depends_on = [docker_container.api]
  ports {
    internal = 80
    external = var.web_port
  }
  networks_advanced {
    name = docker_network.net.name
  }
}