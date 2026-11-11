locals {
  airflow_secrets = {
    "fernet-key"    = var.airflow_secrets.fernet-key
    "webserver-key" = var.airflow_secrets.webserver-key
    "git-secret"    = file(var.airflow_secrets.git-secret)
  }
}