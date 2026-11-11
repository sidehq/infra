output "project_name" {
  description = "Para el `wrangler pages deploy --project-name` del CI"
  value       = cloudflare_pages_project.this.name
}

output "url" {
  value = "https://${cloudflare_pages_domain.this.name}"
}
