variable "project" {
  description = "ID del proyecto de GCP"
  type        = string
}

variable "workload_pool" {
  description = "Workload pool del cluster (<project>.svc.id.goog)"
  type        = string
}

variable "workload_identities" {
  description = "GSA por KSA: la clave es el account_id de la GSA"
  type = map(object({
    namespace = string
    ksa       = string
    roles     = list(string)
  }))
}
