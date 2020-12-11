resource "google_service_account" "gh_actions" {
  account_id   = "gh-actions"
  display_name = "GH Actions"
}

resource "google_project_iam_binding" "gh_actions_storage" {
  role = "roles/storage.admin"

  members = [
    "serviceAccount:${google_service_account.gh_actions.email}",
  ]
}

resource "google_project_iam_binding" "gh_actions_cloudrun" {
  role = "roles/run.admin"

  members = [
    "serviceAccount:${google_service_account.gh_actions.email}",
  ]
}

resource "google_project_iam_binding" "gh_actions_act_as" {
  role = "roles/iam.serviceAccountUser"

  members = [
    "serviceAccount:${google_service_account.gh_actions.email}",
  ]
}

resource "google_service_account_key" "gh_actions" {
  service_account_id = google_service_account.gh_actions.name
}
