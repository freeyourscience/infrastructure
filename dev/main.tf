provider "google" {
  project = "stunning-oasis-298115"
  region  = "us-west1"
}

provider "github" {}

resource "google_service_account" "gh_actions" {
  account_id   = "gh-actions"
  display_name = "GH Actions"
}

resource "google_project_iam_binding" "gh_actions" {
  role = "roles/storage.admin"

  members = [
    "serviceAccount:${google_service_account.gh_actions.email}",
  ]
}

resource "google_service_account_key" "gh_actions" {
  service_account_id = google_service_account.gh_actions.name
}

data "github_actions_public_key" "example_public_key" {
  repository = "wissenschaftsbefreiungsfront"
}

resource "github_actions_secret" "example_secret" {
  repository       = "wissenschaftsbefreiungsfront"
  secret_name      = "GOOGLE_APPLICATION_CREDENTIALS"
  plaintext_value  = google_service_account_key.gh_actions.private_key
}
