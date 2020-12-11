output "sa_key" {
  value       = google_service_account_key.gh_actions.private_key
  description = "credentials for the service account to be used by gh-actions"
}
