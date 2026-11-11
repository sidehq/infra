resource "google_project_service" "apikeys" {
  project = var.project
  service = "apikeys.googleapis.com"
}

# Key nueva: la vieja está en el historial de git y hay que rotarla, no solo restringirla
resource "google_apikeys_key" "front" {
  project      = var.project
  name         = "front-maps"
  display_name = "Maps del front (${var.front_origin})"

  restrictions {
    browser_key_restrictions {
      allowed_referrers = ["${var.front_origin}/*"]
    }

    # Lo que carga el front: el loader de Maps JS y la librería places (PlaceAutocompleteElement)
    api_targets {
      service = "maps-backend.googleapis.com"
    }
    api_targets {
      service = "places.googleapis.com"
    }
  }

  depends_on = [google_project_service.apikeys]
}
