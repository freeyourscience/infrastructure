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

resource "google_monitoring_uptime_check_config" "paper_api" {
  display_name = "paperpage-https-uptime-check"
  timeout      = "20s"
  period       = "900s"

  http_check {
    path         = "/papers?doi=+10.7554%2FeLife.07157"
    port         = "4443"
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

resource "google_monitoring_notification_channel" "team" {
  display_name = "Team@fyscience"
  type         = "email"
  labels = {
    email_address = "team@freeyourscience.org"
  }
}

resource "google_monitoring_alert_policy" "uptime_checks" {
  display_name = "Availability -- Uptime Checks"
  combiner     = "OR"
  conditions {
    display_name = "Failure of uptime check"
    condition_threshold {
      aggregations {
        alignment_period     = "1200s"
        per_series_aligner   = "ALIGN_NEXT_OLDER"
        cross_series_reducer = "REDUCE_COUNT_FALSE"
        group_by_fields      = ["resource.label.*"]
      }
      comparison = "COMPARISON_GT"
      duration   = "90s"
      filter     = "metric.type=\"monitoring.googleapis.com/uptime_check/check_passed\" AND resource.type=\"uptime_url\""
    }
  }
  notification_channels = [ google_monitoring_notification_channel.team.name ]
}

resource "google_monitoring_alert_policy" "server_errors" {
  display_name = "Availability -- 5xx Responses"
  combiner     = "OR"
  conditions {
    display_name = "5xx response count"
    condition_threshold {
      filter = "resource.type=\"cloud_run_revision\" AND metric.type=\"run.googleapis.com/request_count\" AND resource.label.service_name=\"wbf-dev\" AND metric.label.response_code_class=\"5xx\""
      aggregations {
        alignment_period     = "300s"
        cross_series_reducer = "REDUCE_SUM"
        per_series_aligner   = "ALIGN_DELTA"
      }
      comparison      = "COMPARISON_GT"
      threshold_value = 0.0
      duration        = "0s"
    }
  }
  notification_channels = [ google_monitoring_notification_channel.team.name ]
}
