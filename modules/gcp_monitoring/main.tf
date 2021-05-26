resource "google_monitoring_notification_channel" "team" {
  display_name = "Team@fyscience"
  type         = "email"
  labels = {
    email_address = "team@freeyourscience.org"
  }
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
  notification_channels = [google_monitoring_notification_channel.team.name]
}
