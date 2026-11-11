output "api_key" {
  description = "Va como secret VUE_APP_GMAPS_KEY del Environment production del front"
  value       = google_apikeys_key.front.key_string
  sensitive   = true
}
