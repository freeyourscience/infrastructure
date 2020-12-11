locals {
  repo_name = "wissenschaftsbefreiungsfront"
}

data "google_project" "project" {}

data "github_actions_public_key" "example_public_key" {
  repository = local.repo_name
}

resource "github_actions_secret" "non_sensitive" {
  for_each = {
    GCP_PROJECT_ID       = basename(data.google_project.project.id)
    GCP_CLOUDRUN_SERVICE = "wbf-dev"
    GCP_REGION           = "us-west1"
    API_EMAIL            = "team@paywall.lol"
  }
  repository      = local.repo_name
  secret_name     = each.key
  plaintext_value = each.value
}

resource "github_actions_secret" "sa_key" {
  repository      = local.repo_name
  secret_name     = "GCP_SA_KEY"
  plaintext_value = var.sa_key
}

resource "github_actions_secret" "sherpa_api_key" {
  repository      = local.repo_name
  secret_name     = "SHERPA_API_KEY"
  plaintext_value = var.sherpa_api_key
}
