variable "project" {
  description = "ID del proyecto de GCP"
  type        = string
}

variable "services_list" {
  description = "APIs que necesita el cluster"
  type        = list(string)
  default = [
    "compute.googleapis.com",
    "container.googleapis.com",
    "iam.googleapis.com",
    "iamcredentials.googleapis.com", # tokens de Workload Identity
    "secretmanager.googleapis.com",
  ]
}
