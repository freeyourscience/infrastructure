provider "google" {
  project = "stunning-oasis-298115"
  region  = "us-west1"
}

provider "github" {}

data "google_project" "project" {
}

resource "google_container_registry" "registry" {}

data "github_actions_public_key" "example_public_key" {
  repository = "wissenschaftsbefreiungsfront"
}

resource "google_project_service" "iam" {
  service = "iam.googleapis.com"
}

resource "google_project_service" "gcr" {
  service = "containerregistry.googleapis.com"
}

resource "google_project_service" "run" {
  service = "run.googleapis.com"
}

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

resource "github_actions_secret" "sa_key" {
  repository       = "wissenschaftsbefreiungsfront"
  secret_name      = "GCP_SA_KEY"
  plaintext_value  = google_service_account_key.gh_actions.private_key
}

resource "github_actions_secret" "gcp_project_id" {
  repository       = "wissenschaftsbefreiungsfront"
  secret_name      = "GCP_PROJECT_ID"
  plaintext_value  = basename(data.google_project.project.id)
}

resource "github_actions_secret" "gcp_cloudrun_service" {
  repository       = "wissenschaftsbefreiungsfront"
  secret_name      = "GCP_CLOUDRUN_SERVICE"
  plaintext_value  = "wbf-dev"
}

resource "github_actions_secret" "gcp_region" {
  repository       = "wissenschaftsbefreiungsfront"
  secret_name      = "GCP_REGION"
  plaintext_value  = "us-west1"
}
