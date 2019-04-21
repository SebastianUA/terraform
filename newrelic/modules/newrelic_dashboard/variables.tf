#-----------------------------------------------------------
# Global 
#-----------------------------------------------------------
variable "name" {
    description = "The name for newrelic_alert resources"
    default     = "test"
}   

variable "environment" {
    description = "environment"
    default     = "prod"
}

#-----------------------------------------------------------
# newrelic dashboard
#-----------------------------------------------------------
variable "dashboard" {
    description = "Enable newrelic_dashboard"
    default     = "false"
}

variable "dashboard_title" {
    description = "(Required) The title of the dashboard."
    default     = ""
}

variable "dashboard_icon" {
    description = "(Optional) The icon for the dashboard. Defaults to bar-chart."
    default     = "bar-chart"
}

variable "dashboard_visibility" {
    description = "(Optional) Who can see the dashboard in an account. Must be owner or all. Defaults to all."
    default     = "all"
}

variable "dashboard_editable" {
    description = "(Optional) Who can edit the dashboard in an account. Must be read_only, editable_by_owner, editable_by_all, or all. Defaults to editable_by_all."
    default     = "editable_by_all"
}

variable "dashboard_widget_title" {
    description = "(Required) A title for the widget."
    default     = ""
}

variable "dashboard_widget_row" {
    description = "(Required) Row position of widget from top left, starting at 1."
    default     = 1
}

variable "dashboard_widget_visualization" {
    description = "(Required) How the widget visualizes data."
    default     = "faceted_line_chart"
}

variable "dashboard_widget_column" {
    description = "(Required) Column position of widget from top left, starting at 1."
    default     = 1
}

variable "dashboard_widget_width" {
    description = "(Optional) Width of the widget. Defaults to 1."
    default     = 1
}

variable "dashboard_widget_height" {
    description = "(Optional) Height of the widget. Defaults to 1."
    default     = 1
}

variable "dashboard_widget_notes" {
    description = "(Optional) Description of the widget."
    default     = ""
}

variable "dashboard_widget_nrql" {
    description = "(Optional) Valid NRQL query string. See Writing NRQL Queries for help."
    default     = ""
}

variable "dashboard_custom" {
    description = "Enable newrelic_dashboard for custom usage"
    default     = "false"
}

variable "dashboard_custom_widget" {
    description = "(Optional) A widget that describes a visualization. See Widgets below for details."
    type        = "list"
    default     = []
}
