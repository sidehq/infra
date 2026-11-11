resource "cloudflare_zero_trust_access_policy" "admins" {
  account_id       = var.account_id
  name             = "Admins"
  decision         = "allow"
  session_duration = "24h"
  include          = [for email in var.admin_emails : { email = { email = email } }]
}

# Solo la API: la ruta /admin del SPA navega en el cliente y nunca pasaría por Access
resource "cloudflare_zero_trust_access_application" "admin_api" {
  account_id       = var.account_id
  name             = "API de admin"
  type             = "self_hosted"
  session_duration = "24h"

  destinations = [{
    type = "public"
    uri  = "${var.api_subdomain}.${var.domain}/v1/admin/*"
  }]

  # El preflight lo responde el CORS de FastAPI; Access no admite esto junto con cors_headers
  options_preflight_bypass   = true
  http_only_cookie_attribute = true
  same_site_cookie_attribute = "lax"

  policies = [{
    id         = cloudflare_zero_trust_access_policy.admins.id
    precedence = 1
  }]
}
