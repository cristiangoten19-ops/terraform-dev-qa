variable "env" {
  type = string
}

variable "web_port" {
  type = number
}

variable "api_port" {
  type = number
}

variable "db_port" {
  type = number
}

variable "root_path" {
  type = string
}

variable "db_user" {
  type    = string
  default = "appuser"
}

variable "db_name" {
  type    = string
  default = "appdb"
}

variable "db_password" {
  type      = string
  sensitive = true
}