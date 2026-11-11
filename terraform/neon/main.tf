# Un project por servicio: las cuotas del plan Free (storage, CU-horas, egress) son por project
resource "neon_project" "this" {
  for_each = var.databases

  name       = each.key
  region_id  = var.region_id
  pg_version = var.pg_version

  # El plan Free solo guarda 6 h de historia; el default del provider (1 día) falla
  history_retention_seconds = 21600

  branch {
    name          = "main"
    database_name = each.value.database
    role_name     = each.value.role
  }
}
