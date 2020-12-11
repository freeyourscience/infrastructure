data "google_project" "project" {}

data "github_actions_public_key" "example_public_key" {
  repository = "wissenschaftsbefreiungsfront"
}

resource "github_actions_secret" "sa_key" {
  repository      = "wissenschaftsbefreiungsfront"
  secret_name     = "GCP_SA_KEY"
  plaintext_value = var.sa_key
}

resource "github_actions_secret" "gcp_project_id" {
  repository      = "wissenschaftsbefreiungsfront"
  secret_name     = "GCP_PROJECT_ID"
  plaintext_value = basename(data.google_project.project.id)
}

resource "github_actions_secret" "gcp_cloudrun_service" {
  repository      = "wissenschaftsbefreiungsfront"
  secret_name     = "GCP_CLOUDRUN_SERVICE"
  plaintext_value = "wbf-dev"
}

resource "github_actions_secret" "gcp_region" {
  repository      = "wissenschaftsbefreiungsfront"
  secret_name     = "GCP_REGION"
  plaintext_value = "us-west1"
}
