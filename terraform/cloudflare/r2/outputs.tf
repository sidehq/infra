output "public_urls" {
  description = "URL pública por bucket, para el STORAGE_PUBLIC_BASE_URL de cada servicio"
  value       = { for name, d in cloudflare_r2_custom_domain.this : name => "https://${d.domain}" }
}

output "buckets" {
  value = [for b in cloudflare_r2_bucket.this : b.name]
}
