# Sin source de Git: los deploys los sube el CI del front con wrangler, después de lint y tests
resource "cloudflare_pages_project" "this" {
  account_id        = var.account_id
  name              = var.project_name
  production_branch = "main"
}

resource "cloudflare_pages_domain" "this" {
  account_id   = var.account_id
  project_name = cloudflare_pages_project.this.name
  name         = "${var.subdomain}.${var.domain}"
}

resource "cloudflare_dns_record" "this" {
  zone_id = var.zone_id
  name    = "${var.subdomain}.${var.domain}"
  type    = "CNAME"
  content = "${cloudflare_pages_project.this.name}.pages.dev"
  proxied = true
  ttl     = 1
}
