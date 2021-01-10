data "google_billing_account" "account" {
  provider        = google-beta
  billing_account = "013330-B5C346-2D4F40"
}

resource "google_billing_budget" "budget" {
  provider        = google-beta
  billing_account = data.google_billing_account.account.id
  display_name    = "Free Your Science"

  budget_filter {
    projects = ["projects/${var.gcp_project}"]
  }

  amount {
    specified_amount {
      currency_code = "USD"
      units         = "0.02"
    }
  }

  threshold_rules {
    threshold_percent = 0.5
  }
  threshold_rules {
    threshold_percent = 1.0
  }
  threshold_rules {
    threshold_percent = 0.5
    spend_basis       = "FORECASTED_SPEND"
  }
  threshold_rules {
    threshold_percent = 1.0
    spend_basis       = "FORECASTED_SPEND"
  }
}
