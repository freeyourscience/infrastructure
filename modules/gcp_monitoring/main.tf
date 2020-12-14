resource "google_monitoring_uptime_check_config" "landingpage_https" {
  display_name = "landingpage-https-uptime-check"
  timeout      = "20s"
  period       = "900s"

  http_check {
    path         = "/"
    port         = "443"
    use_ssl      = true
    validate_ssl = true
  }

  monitored_resource {
    type = "uptime_url"

    labels = {
      project_id = var.gcp_project
      host       = "dev.${var.domain_name}"
    }
  }
}
