variable "account_id" {
  description = "ID de la cuenta de Cloudflare"
  type        = string
}

variable "domain" {
  description = "Dominio de la zona"
  type        = string
}

variable "api_subdomain" {
  description = "Subdominio de la API"
  type        = string
  default     = "api"
}

variable "admin_emails" {
  description = "Correos que pasan Access; van en terraform.tfvars, no en el repo"
  type        = list(string)
}
