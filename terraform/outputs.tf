output "cluster_name" {
  value = module.gke.cluster_name
}

output "cluster_location" {
  value = module.gke.cluster_location
}

output "workload_identity_gsas" {
  description = "Email de la GSA por KSA, para la anotación iam.gke.io/gcp-service-account"
  value       = module.gke.workload_identity_gsas
}

output "neon_projects" {
  value = module.neon.projects
}

output "front_url" {
  value = module.cloudflare.front_url
}

output "pages_project_name" {
  value = module.cloudflare.pages_project_name
}

output "r2_public_urls" {
  value = module.cloudflare.r2_public_urls
}

output "maps_api_key" {
  value     = module.maps.api_key
  sensitive = true
}
