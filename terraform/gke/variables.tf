variable "project" {
  description = "ID del proyecto de GCP"
  type        = string
}

variable "region" {
  description = "Región de la red y la subnet"
  type        = string
}

variable "zone" {
  description = "Zona del cluster (zonal: el tráfico entre pods no cruza zonas)"
  type        = string
}

variable "name" {
  description = "Prefijo de la VPC, la subnet, el cluster y el node pool"
  type        = string
  default     = "side"
}

variable "machine_type" {
  description = "Tipo de máquina de los nodos"
  type        = string
  default     = "e2-standard-2"
}

variable "node_count" {
  description = "Número de nodos del pool"
  type        = number
  default     = 1
}

variable "workload_identities" {
  description = "GSA por KSA vía Workload Identity. Solo los pods con su KSA en este mapa pueden usar una cuenta de GCP"
  type = map(object({
    namespace = string
    ksa       = string
    roles     = list(string)
  }))
  default = {
    external-secrets = {
      namespace = "external-secrets"
      ksa       = "external-secrets"
      roles     = ["roles/secretmanager.secretAccessor"]
    }
  }
}
