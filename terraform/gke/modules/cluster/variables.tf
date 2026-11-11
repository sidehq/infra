variable "project" {
  description = "ID del proyecto de GCP"
  type        = string
}

variable "zone" {
  description = "Zona del cluster y del node pool"
  type        = string
}

variable "name" {
  description = "Nombre del cluster y prefijo del node pool y su cuenta"
  type        = string
}

variable "network" {
  description = "ID de la VPC"
  type        = string
}

variable "subnetwork" {
  description = "ID de la subnet de los nodos"
  type        = string
}

variable "pods_range" {
  description = "Nombre del rango secundario de pods"
  type        = string
}

variable "svc_range" {
  description = "Nombre del rango secundario de Services"
  type        = string
}

variable "max_pods_per_node" {
  description = "Máximo de pods por nodo; 64 hace que GKE reserve un /25 por nodo"
  type        = number
  default     = 64
}

variable "machine_type" {
  description = "Tipo de máquina de los nodos"
  type        = string
}

variable "node_count" {
  description = "Número de nodos del pool"
  type        = number
}

variable "disk_size" {
  description = "Disco por nodo en GB"
  type        = number
  default     = 40
}
