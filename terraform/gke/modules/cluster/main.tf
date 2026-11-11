# Cuenta propia para los nodos en vez de la default de Compute (que tiene Editor)
resource "google_service_account" "nodes" {
  project      = var.project
  account_id   = "${var.name}-gke-nodes"
  display_name = "Nodos de GKE (${var.name})"
}

resource "google_project_iam_member" "nodes" {
  project = var.project
  role    = "roles/container.defaultNodeServiceAccount"
  member  = "serviceAccount:${google_service_account.nodes.email}"
}

resource "google_container_cluster" "this" {
  name     = var.name
  project  = var.project
  location = var.zone

  remove_default_node_pool = true
  initial_node_count       = 1

  network    = var.network
  subnetwork = var.subnetwork

  default_max_pods_per_node = var.max_pods_per_node

  ip_allocation_policy {
    cluster_secondary_range_name  = var.pods_range
    services_secondary_range_name = var.svc_range
  }

  workload_identity_config {
    workload_pool = "${var.project}.svc.id.goog"
  }

  deletion_protection = false
}

resource "google_container_node_pool" "nodes" {
  name       = "${var.name}-pool"
  project    = var.project
  location   = var.zone
  cluster    = google_container_cluster.this.name
  node_count = var.node_count

  node_config {
    spot            = true
    machine_type    = var.machine_type
    disk_size_gb    = var.disk_size
    service_account = google_service_account.nodes.email
    oauth_scopes    = ["https://www.googleapis.com/auth/cloud-platform"]

    # Los pods ven el metadata server de GKE, no el de la VM: sin binding de KSA no obtienen credenciales
    workload_metadata_config {
      mode = "GKE_METADATA"
    }
  }

  management {
    auto_repair  = true
    auto_upgrade = true
  }

  depends_on = [google_project_iam_member.nodes]
}
