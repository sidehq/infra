module "services" {
  source  = "./modules/services"
  project = var.project
}

module "network" {
  source  = "./modules/network"
  project = var.project
  region  = var.region
  name    = var.name

  depends_on = [module.services]
}

module "cluster" {
  source       = "./modules/cluster"
  project      = var.project
  zone         = var.zone
  name         = var.name
  network      = module.network.network_id
  subnetwork   = module.network.subnetwork_id
  pods_range   = module.network.pods_range_name
  svc_range    = module.network.services_range_name
  machine_type = var.machine_type
  node_count   = var.node_count
}

module "identity" {
  source              = "./modules/identity"
  project             = var.project
  workload_pool       = module.cluster.workload_pool
  workload_identities = var.workload_identities
}
