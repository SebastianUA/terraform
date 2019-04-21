#---------------------------------------------------
# Add newrelic dashboard
#---------------------------------------------------
resource "newrelic_dashboard" "dashboard" {
    count               = "${var.dashboard && !var.dashboard_custom ? 1 : 0}"
                                 
    title               = "${var.dashboard_title !="" ? "${lower(var.dashboard_title)}" : "${lower(var.name)}-nr-dashboard-${lower(var.environment)}" }"
    icon                = "${var.dashboard_icon}"
    visibility          = "${var.dashboard_visibility}"
    editable            = "${var.dashboard_editable}"

    widget {
        title           = "${var.dashboard_widget_title !="" ? "${lower(var.dashboard_widget_title)}" : "${lower(var.name)}-nr-widget-${lower(var.environment)}" }"
        visualization   = "${var.dashboard_widget_visualization}"
        row             = "${var.dashboard_widget_row}"
        column          = "${var.dashboard_widget_column}"

        width           = "${var.dashboard_widget_width}"
        height          = "${var.dashboard_widget_height}"
        notes           = "${var.dashboard_widget_notes}"
        nrql            = "${var.dashboard_widget_nrql}"
    }
    
    widget {
        title         = "Page Views"
        row           = 1
        column        = 3
        visualization = "billboard"
        nrql          = "SELECT count(*) FROM PageView SINCE 1 week ago"
    }

    lifecycle = {
        create_before_destroy   = true,
        ignore_changes          = []
    }

    depends_on  = []    
}

resource "newrelic_dashboard" "dashboard_custom" {
    count               = "${var.dashboard && var.dashboard_custom ? 1 : 0}"

    title               = "${var.dashboard_title !="" ? "${lower(var.dashboard_title)}" : "${lower(var.name)}-nr-dashboard-${lower(var.environment)}" }"
    icon                = "${var.dashboard_icon}"
    visibility          = "${var.dashboard_visibility}"
    editable            = "${var.dashboard_editable}"

    widget              = "${var.dashboard_custom_widget}"

    lifecycle = {
        create_before_destroy   = true,
        ignore_changes          = []
    }

    depends_on  = []
}

