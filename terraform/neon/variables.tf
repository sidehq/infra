variable "region_id" {
  description = "Región de Neon; misma ciudad que GKE (aws-sa-east-1 o aws-us-east-1)"
  type        = string
}

variable "pg_version" {
  description = "Versión de Postgres"
  type        = number
  default     = 17
}

variable "databases" {
  description = "Un project por clave, con su base y su role owner. Los nombres de base son los de dev"
  type = map(object({
    database = string
    role     = string
  }))
  default = {
    users      = { database = "identity_service_db", role = "users" }
    catalog    = { database = "catalog_service_db", role = "catalog" }
    properties = { database = "properties", role = "properties" }
    analytics  = { database = "analytics", role = "analytics" }
    keycloak   = { database = "keycloak", role = "keycloak" }
  }
}
