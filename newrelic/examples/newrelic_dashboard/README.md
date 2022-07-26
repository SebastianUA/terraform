# Work with NEWRELIC_DASHBOARD via terraform

A terraform module for making NEWRELIC_DASHBOARD.


## Usage
----------------------
Import the module and retrieve with ```terraform get``` or ```terraform get --update```. Adding a module resource to your template, e.g. `main.tf`:

```
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

```

## Module Input Variables
----------------------
- `name` - The name for newrelic_alert resources (`default = test`)
- `environment` - environment (`default = prod`)
- `dashboard` - Enable newrelic_dashboard (`default = False`)
- `dashboard_title` - (Required) The title of the dashboard. (`default = ""`)
- `dashboard_icon` - (Optional) The icon for the dashboard. Defaults to bar-chart. (`default = null`)
- `dashboard_visibility` - (Optional) Who can see the dashboard in an account. Must be owner or all. Defaults to all. (`default = all`)
- `dashboard_editable` - (Optional) Who can edit the dashboard in an account. Must be read_only, editable_by_owner, editable_by_all, or all. Defaults to editable_by_all. (`default = editable_by_all`)
- `dashboard_widget_title` - (Required) A title for the widget. (`default = ""`)
- `dashboard_widget_row` - (Required) Row position of widget from top left, starting at 1. (`default = 1`)
- `dashboard_widget_visualization` - (Required) How the widget visualizes data. (`default = faceted_line_chart`)
- `dashboard_widget_column` - (Required) Column position of widget from top left, starting at 1. (`default = 1`)
- `dashboard_widget_width` - (Optional) Width of the widget. Defaults to 1. (`default = 1`)
- `dashboard_widget_height` - (Optional) Height of the widget. Defaults to 1. (`default = 1`)
- `dashboard_widget_notes` - (Optional) Description of the widget. (`default = null`)
- `dashboard_widget_nrql` - (Optional) Valid NRQL query string. See Writing NRQL Queries for help. (`default = null`)
- `dashboard_custom` - Enable newrelic_dashboard for custom usage (`default = False`)
- `dashboard_custom_widget` - (Optional) A widget that describes a visualization. See Widgets below for details. (`default = []`)

## Module Output Variables
----------------------
- `newrelic_dashboard_id` - ID for newrelic_dashboard
- `newrelic_dashboard_custom_id` - ID for dashboard_custom


## Authors

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA). An email: [vitaliy.natarov@yahoo.com](vitaliy.natarov@yahoo.com).

## License

Apache 2 Licensed. See [LICENSE](https://github.com/SebastianUA/terraform/blob/master/LICENSE) for full details.
