module "r2" {
  source         = "./r2"
  account_id     = var.account_id
  zone_id        = var.zone_id
  domain         = var.domain
  upload_origins = ["https://${var.front_subdomain}.${var.domain}"]
}

module "front" {
  source       = "./front"
  account_id   = var.account_id
  zone_id      = var.zone_id
  domain       = var.domain
  subdomain    = var.front_subdomain
  project_name = var.pages_project_name
}

module "access" {
  source       = "./access"
  account_id   = var.account_id
  domain       = var.domain
  admin_emails = var.admin_emails
}
