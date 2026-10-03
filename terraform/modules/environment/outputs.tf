output "urls" {
  value = {
    web = "http://localhost:${var.web_port}"
    api = "http://localhost:${var.api_port}/api/info"
    db  = "localhost:${var.db_port}"
  }
}