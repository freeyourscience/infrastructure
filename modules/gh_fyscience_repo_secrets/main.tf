locals {
  repo_name = "freeyourscience"
}

data "github_actions_public_key" "example_public_key" {
  repository = local.repo_name
}

resource "github_actions_secret" "non_sensitive" {
  for_each = {
    GCP_PROJECT_ID           = var.gcp_project
    GCP_CLOUDRUN_SERVICE     = var.cloudrun_svc
    GCP_CLOUDRUN_SERVICE_DEV = var.cloudrun_svc_dev
    GCP_REGION               = var.gcp_region
    GCP_SERVICEACCOUNT_EMAIL = var.cloudrun_sa_email
    API_EMAIL                = "team@${var.domain_name}"
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

resource "github_actions_secret" "s2_api_key" {
  repository      = local.repo_name
  secret_name     = "S2_API_KEY"
  plaintext_value = var.s2_api_key
}
