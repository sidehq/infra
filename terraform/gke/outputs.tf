output "cluster_name" {
  value = module.cluster.name
}

output "cluster_location" {
  value = module.cluster.location
}

output "workload_identity_gsas" {
  description = "Email de la GSA por KSA, para la anotación iam.gke.io/gcp-service-account"
  value       = module.identity.gsa_emails
}
