#
# MAINTAINER Vitaliy Natarov "vitaliy.natarov@yahoo.com"
#
terraform {
  required_version = "~> 0.13"
}

provider "newrelic" {
  api_key    = "api_key"
  account_id = "account_id"
}

module "newrelic_dashboard" {
  source = "../../modules/newrelic_dashboard"

  dashboard = "true"

  dashboard_custom = "true"
  dashboard_custom_widget = [
    {
      title         = "Average Transaction Duration"
      row           = 1
      column        = 1
      width         = 2
      visualization = "faceted_line_chart"
      nrql          = "SELECT AVERAGE(duration) from Transaction FACET appName TIMESERIES auto"
    },
    {
      title         = "Page Views"
      row           = 1
      column        = 3
      visualization = "billboard"
      nrql          = "SELECT count(*) FROM PageView SINCE 1 week ago"
    }
  ]
}
