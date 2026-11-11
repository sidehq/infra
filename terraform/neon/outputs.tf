output "projects" {
  description = "Project, host, base y role por servicio (sin credenciales)"
  value = {
    for k, p in neon_project.this : k => {
      id       = p.id
      host     = p.database_host
      database = p.database_name
      role     = p.database_user
    }
  }
}

output "connection_uris" {
  description = "URI con credenciales por servicio, para llevarlas a Secret Manager"
  value       = { for k, p in neon_project.this : k => p.connection_uri }
  sensitive   = true
}
