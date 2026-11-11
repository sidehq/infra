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

variable "location" {
  description = "Ubicación sugerida de los buckets. R2 no tiene Sudamérica; enam es la más cercana"
  type        = string
  default     = "enam"
}

variable "upload_origins" {
  description = "Orígenes que pueden subir con URL presignada"
  type        = list(string)
}

variable "buckets" {
  description = "Buckets de R2. public_subdomain en null deja el bucket privado; los TTL son en segundos"
  type = map(object({
    public_subdomain = optional(string)
    browser_upload   = optional(bool, false)
    edge_ttl         = optional(number, 3600)
    browser_ttl      = optional(number, 300)
  }))
  default = {
    # La foto de perfil se sobrescribe en la misma key: TTL corto o se sirve la vieja
    profile-photos = { public_subdomain = "avatars" }
    # Keys con UUID que no cambian: TTL largo
    property-images  = { public_subdomain = "img", browser_upload = true, edge_ttl = 2592000, browser_ttl = 604800 }
    properties       = { browser_upload = true } # CSV de imports del admin
    mlflow-artifacts = {}                        # modelo del AVM
  }
}
