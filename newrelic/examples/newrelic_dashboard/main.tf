#
# MAINTAINER Vitaliy Natarov "vitaliy.natarov@yahoo.com"
#
terraform {
  required_version = "~> 0.11.11"
}

provider "newrelic" {
    api_key = "75e6741e6326cce1666ecfb94c3c0b8fdf"
}

module "newrelic_dashboard" {
    source                                              = "../../modules/newrelic_dashboard"

    dashboard                                           = "true"
    
    dashboard_custom                                    = "true"
    dashboard_custom_widget                             = [
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
