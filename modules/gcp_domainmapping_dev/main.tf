data "google_project" "project" {}
resource "google_cloud_run_domain_mapping" "dev_paywall_lol" {
  location = "us-west1"
  name     = "dev.paywall.lol"

  spec {
    route_name = "wbf-dev"
  }

  metadata {
    namespace = basename(data.google_project.project.id)
  }
}
