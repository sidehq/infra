module "services" {
  source  = "./modules/services"
  project = var.project
}

module "buckets" {
  source         = "./modules/Buckets"
  bucket_name    = var.bucket_name
  project_region = var.project_region
  bucket_class   = var.bucket_class
  depends_on     = [module.services]
}

module "repository" {
  source               = "./modules/repository"
  project              = var.project
  project_region       = var.project_region
  repository_id        = var.repository_id
  repository_format    = var.repository_format
  service_account_name = var.service_account_name
  depends_on           = [module.services]
}

module "kubernetes" {
  source              = "./modules/Kubernetes"
  project             = var.project
  project_region      = var.project_region
  project_region_zone = var.project_region_zone
  vpc_name            = var.vpc_name
  vpc_subnet_name     = var.vpc_subnet_name
  gke_name            = var.gke_name
  depends_on          = [module.services]
}

module "secrets" {
  source          = "./modules/secrets"
  airflow_secrets = local.airflow_secrets
  depends_on      = [module.kubernetes]
}

module "gke_auth" {
  source = "terraform-google-modules/kubernetes-engine/google//modules/auth"
  project_id           = var.project
  cluster_name         = module.kubernetes.kubernetes_name
  location             = module.kubernetes.kubernetes_location
  use_private_endpoint = false

  depends_on = [module.kubernetes]
}

module "kubernetes_resources" {
  source     = "./modules/kubernetesResources"
  depends_on = [module.gke_auth]
}

module "kubernetes_identity" {
  source     = "./modules/kubernetesIdentity"
  project    = var.project
  depends_on = [module.kubernetes_resources]
}

data "kubectl_path_documents" "docs" {
    pattern = "../configuration/*.yaml"
}

resource "kubectl_manifest" "test" {
    for_each  = toset(data.kubectl_path_documents.docs.documents)
    yaml_body = each.value
    depends_on = [module.kubernetes_identity]
}