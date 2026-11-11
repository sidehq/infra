# Credenciales por ADC (`gcloud auth application-default login`), sin key JSON
provider "google" {
  project = var.project
  region  = var.region
}

# La API key sale de NEON_API_KEY
provider "neon" {}

# El token sale de CLOUDFLARE_API_TOKEN
provider "cloudflare" {}
