variable "account_id" {
  description = "ID de la cuenta de Cloudflare"
  type        = string
}

variable "zone_id" {
  description = "ID de la zona del dominio"
  type        = string
}

variable "domain" {
  description = "Dominio de la zona"
  type        = string
}

variable "front_subdomain" {
  description = "Subdominio del front"
  type        = string
  default     = "app"
}

variable "pages_project_name" {
  description = "Nombre del proyecto de Pages"
  type        = string
}

variable "admin_emails" {
  description = "Correos que pasan Access delante de la API de admin"
  type        = list(string)
}
