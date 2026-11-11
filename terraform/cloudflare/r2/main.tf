locals {
  public  = { for name, b in var.buckets : name => b if b.public_subdomain != null }
  uploads = { for name, b in var.buckets : name => b if b.browser_upload }
}

resource "cloudflare_r2_bucket" "this" {
  for_each   = var.buckets
  account_id = var.account_id
  name       = each.key
  location   = var.location
}

# El bucket se sirve en la raíz del subdominio (https://img.<dominio>/<key>), sin el nombre en la ruta
resource "cloudflare_r2_custom_domain" "this" {
  for_each    = local.public
  account_id  = var.account_id
  zone_id     = var.zone_id
  bucket_name = cloudflare_r2_bucket.this[each.key].name
  domain      = "${each.value.public_subdomain}.${var.domain}"
  enabled     = true
  min_tls     = "1.2"
}

# El navegador sube directo con la URL presignada
resource "cloudflare_r2_bucket_cors" "this" {
  for_each    = local.uploads
  account_id  = var.account_id
  bucket_name = cloudflare_r2_bucket.this[each.key].name

  rules = [{
    id = "presigned-uploads"
    allowed = {
      methods = ["PUT", "GET"]
      origins = var.upload_origins
      headers = ["content-type"]
    }
    max_age_seconds = 3600
  }]
}

# Una zona admite un solo ruleset por fase: si otra parte necesita reglas de caché, van aquí
resource "cloudflare_ruleset" "cache" {
  zone_id = var.zone_id
  name    = "Caché de los buckets públicos"
  kind    = "zone"
  phase   = "http_request_cache_settings"

  rules = [for name, b in local.public : {
    ref         = "cache-${name}"
    description = "Caché de ${name}"
    expression  = "http.host eq \"${b.public_subdomain}.${var.domain}\""
    action      = "set_cache_settings"
    action_parameters = {
      cache       = true
      edge_ttl    = { mode = "override_origin", default = b.edge_ttl }
      browser_ttl = { mode = "override_origin", default = b.browser_ttl }
    }
  }]
}
