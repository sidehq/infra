variable "project" {
  description = "ID del proyecto de GCP"
  type        = string
}

variable "region" {
  description = "Región de la subnet"
  type        = string
}

variable "name" {
  description = "Prefijo de la VPC y sus rangos"
  type        = string
}

variable "nodes_cidr" {
  description = "Rango primario de la subnet: IPs de los nodos (256)"
  type        = string
  default     = "10.10.0.0/24"
}

variable "pods_cidr" {
  description = "Rango secundario de pods. Con 64 pods por nodo GKE reserva un /25 por nodo: un /20 alcanza para 32 nodos"
  type        = string
  default     = "10.20.0.0/20"
}

variable "services_cidr" {
  description = "Rango secundario de Services (1024 ClusterIPs)"
  type        = string
  default     = "10.30.0.0/22"
}
