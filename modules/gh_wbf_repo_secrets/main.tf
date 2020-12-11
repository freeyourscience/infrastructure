data "google_project" "project" {}

data "github_actions_public_key" "example_public_key" {
  repository = "wissenschaftsbefreiungsfront"
}

resource "github_actions_secret" "dev_env" {
  for_each = {
    GCP_SA_KEY = var.sa_key
    GCP_PROJECT_ID = basename(data.google_project.project.id)
    GCP_CLOUDRUN_SERVICE = "wbf-dev"
    GCP_REGION = "us-west1"
  }
  repository      = "wissenschaftsbefreiungsfront"
  secret_name     = each.key
  plaintext_value = each.value
}
