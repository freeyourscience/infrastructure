resource "google_cloud_run_domain_mapping" "dev" {
  location = var.gcp_region
  name     = "dev.${var.domain_name}"

  spec {
    route_name = var.dev_route
  }

  metadata {
    namespace = var.gcp_project
  }
}
