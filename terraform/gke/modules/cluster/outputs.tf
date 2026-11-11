output "name" {
  value = google_container_cluster.this.name
}

output "location" {
  value = google_container_cluster.this.location
}

output "workload_pool" {
  value = google_container_cluster.this.workload_identity_config[0].workload_pool
}
