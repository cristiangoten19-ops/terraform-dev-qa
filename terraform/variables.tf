variable "docker_host" {
  type    = string
  default = "npipe:////./pipe/docker_engine"
}

variable "db_password" {
  type      = string
  sensitive = true
  default   = "cambiar123"
}