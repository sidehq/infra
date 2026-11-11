locals {
  roles = merge([
    for gsa, wi in var.workload_identities : {
      for role in wi.roles : "${gsa}/${role}" => { gsa = gsa, role = role }
    }
  ]...)
}

resource "google_service_account" "this" {
  for_each     = var.workload_identities
  project      = var.project
  account_id   = each.key
  display_name = "Workload Identity de ${each.value.namespace}/${each.value.ksa}"
}

resource "google_project_iam_member" "roles" {
  for_each = local.roles
  project  = var.project
  role     = each.value.role
  member   = "serviceAccount:${google_service_account.this[each.value.gsa].email}"
}

# Solo la KSA nombrada puede actuar como la GSA; la KSA la crea su chart, no Terraform
resource "google_service_account_iam_member" "workload_identity" {
  for_each           = var.workload_identities
  service_account_id = google_service_account.this[each.key].id
  role               = "roles/iam.workloadIdentityUser"
  member             = "serviceAccount:${var.workload_pool}[${each.value.namespace}/${each.value.ksa}]"
}
