module "gke" {
  source  = "./gke"
  project = var.project
  region  = var.region
  zone    = var.zone
}

module "neon" {
  source    = "./neon"
  region_id = var.neon_region_id
}

module "cloudflare" {
  source             = "./cloudflare"
  account_id         = var.cloudflare_account_id
  zone_id            = var.cloudflare_zone_id
  domain             = var.domain
  pages_project_name = var.pages_project_name
  admin_emails       = var.admin_emails
}

module "maps" {
  source       = "./maps"
  project      = var.project
  front_origin = module.cloudflare.front_url
}
