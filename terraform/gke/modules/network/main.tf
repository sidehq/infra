resource "google_compute_network" "vpc" {
  name                    = "${var.name}-vpc"
  project                 = var.project
  routing_mode            = "GLOBAL"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "nodes" {
  name          = "${var.name}-nodes"
  project       = var.project
  region        = var.region
  network       = google_compute_network.vpc.id
  ip_cidr_range = var.nodes_cidr

  secondary_ip_range {
    range_name    = "${var.name}-pods"
    ip_cidr_range = var.pods_cidr
  }

  secondary_ip_range {
    range_name    = "${var.name}-services"
    ip_cidr_range = var.services_cidr
  }
}
