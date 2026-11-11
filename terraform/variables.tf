variable "project" {
  description = "ID del proyecto de GCP"
  type        = string
}

variable "region" {
  description = "Región de GCP"
  type        = string
}

variable "zone" {
  description = "Zona del cluster"
  type        = string
}

variable "neon_region_id" {
  description = "Región de Neon; misma ciudad que GKE (aws-sa-east-1 o aws-us-east-1)"
  type        = string
}

variable "domain" {
  description = "Dominio de la zona en Cloudflare; pendiente del rebrand"
  type        = string
}

variable "cloudflare_account_id" {
  description = "ID de la cuenta de Cloudflare"
  type        = string
}

variable "cloudflare_zone_id" {
  description = "ID de la zona del dominio"
  type        = string
}

variable "pages_project_name" {
  description = "Nombre del proyecto de Pages del front"
  type        = string
}

variable "admin_emails" {
  description = "Correos que pasan Zero Trust Access delante de la API de admin"
  type        = list(string)
}
