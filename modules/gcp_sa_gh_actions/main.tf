resource "google_service_account" "gh_actions" {
  account_id   = "gh-actions"
  display_name = "GH Actions"
}

resource "google_project_iam_custom_role" "github_actions" {
  role_id     = "ghActions"
  title       = "Github Actions"
  description = "Registry and Cloud Run access"
  permissions = [
    "iam.serviceAccounts.actAs",
    "run.services.create",
    "run.services.get",
    "run.services.getIamPolicy",
    "run.services.setIamPolicy",
    "run.services.update",
    "storage.buckets.get",
    "storage.objects.create",
    "storage.objects.delete",
    "storage.objects.get",
    "storage.objects.list",
  ]
}
resource "google_project_iam_binding" "gh_actions_storage" {
  role = google_project_iam_custom_role.github_actions.id

  members = [
    "serviceAccount:${google_service_account.gh_actions.email}",
  ]
}

resource "google_service_account_key" "gh_actions" {
  service_account_id = google_service_account.gh_actions.name
}
