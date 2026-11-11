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

variable "subdomain" {
  description = "Subdominio del front"
  type        = string
  default     = "app"
}

variable "project_name" {
  description = "Nombre del proyecto de Pages; define <nombre>.pages.dev"
  type        = string
}
