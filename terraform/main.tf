terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0"
    }
  }
}

provider "docker" {
  host = var.docker_host
}

module "dev" {
  source      = "./modules/environment"
  env         = "dev"
  web_port    = 4001
  api_port    = 4002
  db_port     = 4003
  db_password = var.db_password
  root_path   = abspath("${path.root}/..")
}

module "qa" {
  source      = "./modules/environment"
  env         = "qa"
  web_port    = 5001
  api_port    = 5002
  db_port     = 5003
  db_password = var.db_password
  root_path   = abspath("${path.root}/..")
}