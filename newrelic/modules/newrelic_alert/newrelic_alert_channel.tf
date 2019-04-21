#---------------------------------------------------
# Add newrelic alert channel
#---------------------------------------------------
# campfire
resource "newrelic_alert_channel" "alert_channel_campfire" {
    count   = "${var.newrelic_alert_channel_campfire && var.newrelic_alert_channel ? 1 : 0}"

    name    = "${var.newrelic_alert_channel_campfire_name_custom !="" ? var.newrelic_alert_channel_campfire_name_custom : "${lower(var.name)}-nr-channel-campfire-${lower(var.environment)}" }"
    type    = "campfire"
    
    configuration = {
        room        = "${var.newrelic_alert_channel_campfire_configuration_room}"
        subdomain   = "${var.newrelic_alert_channel_campfire_configuration_subdomain}"
        token       = "${var.newrelic_alert_channel_campfire_configuration_token}"
    }

    lifecycle = {
        create_before_destroy   = true,
        ignore_changes          = []
    }

    depends_on  = []
    
}

#email
resource "newrelic_alert_channel" "alert_channel_email" {
    count   = "${var.newrelic_alert_channel_email && var.newrelic_alert_channel ? 1 : 0}"

    name    = "${var.newrelic_alert_channel_email_name_custom !="" ? var.newrelic_alert_channel_email_name_custom : "${lower(var.name)}-nr-channel-email-${lower(var.environment)}" }"
    type    = "email"

    configuration = {
        recipients              = "${var.newrelic_alert_channel_email_configuration_recipients}"
        include_json_attachment = "${var.newrelic_alert_channel_email_configuration_include_json_attachment}"
    }

    lifecycle = {
        create_before_destroy   = true,
        ignore_changes          = []
    }

    depends_on  = []

}

#opsgenie
resource "newrelic_alert_channel" "alert_channel_opsgenie" {
    count   = "${var.newrelic_alert_channel_opsgenie && var.newrelic_alert_channel ? 1 : 0}"

    name    = "${var.newrelic_alert_channel_opsgenie_name_custom !="" ? var.newrelic_alert_channel_opsgenie_name_custom : "${lower(var.name)}-nr-channel-opsgenie-${lower(var.environment)}" }"
    type    = "opsgenie"

    configuration = {
        api_key                 = "${var.newrelic_alert_channel_opsgenie_configuration_api_key}"
        recipients              = "${var.newrelic_alert_channel_opsgenie_configuration_recipients}"
        tags                    = "${var.newrelic_alert_channel_opsgenie_configuration_tags}"
        teams                   = "${var.newrelic_alert_channel_opsgenie_configuration_teams}"
    }

    lifecycle = {
        create_before_destroy   = true,
        ignore_changes          = []
    }

    depends_on  = []

}

#pagerduty
resource "newrelic_alert_channel" "alert_channel_pagerduty" {
    count   = "${var.newrelic_alert_channel_pagerduty && var.newrelic_alert_channel ? 1 : 0}"

    name    = "${var.newrelic_alert_channel_pagerduty_name_custom !="" ? var.newrelic_alert_channel_pagerduty_name_custom : "${lower(var.name)}-nr-channel-pagerduty-${lower(var.environment)}" }"
    type    = "pagerduty"

    configuration = {
        service_key = "${var.newrelic_alert_channel_pagerduty_configuration_service_key}"
    }

    lifecycle = {
        create_before_destroy   = true,
        ignore_changes          = []
    }

    depends_on  = []

}

#slack
resource "newrelic_alert_channel" "alert_channel_slack" {
    count   = "${var.newrelic_alert_channel_slack && var.newrelic_alert_channel ? 1 : 0}"
        
    name    = "${var.newrelic_alert_channel_slack_name_custom !="" ? var.newrelic_alert_channel_slack_name_custom : "${lower(var.name)}-nr-channel-slack-${lower(var.environment)}" }"
    type    = "slack"

    configuration = {
        channel     = "${var.newrelic_alert_channel_slack_configuration_channel}"
        url         = "${var.newrelic_alert_channel_slack_configuration_url}"
    }

    lifecycle = {
        create_before_destroy   = true,
        ignore_changes          = ["configuration"]
    }

    depends_on  = []

}

#user
resource "newrelic_alert_channel" "alert_channel_user" {
    count   = "${var.newrelic_alert_channel_user && var.newrelic_alert_channel ? 1 : 0}"

    name    = "${var.newrelic_alert_channel_user_name_custom !="" ? var.newrelic_alert_channel_user_name_custom : "${lower(var.name)}-nr-channel-user-${lower(var.environment)}" }"
    type    = "user"

    configuration = {
        user_id     = "${var.newrelic_alert_channel_user_configuration_user_id}"
    }

    lifecycle = {
        create_before_destroy   = true,
        ignore_changes          = []
    }

    depends_on  = []
}

#victorops
resource "newrelic_alert_channel" "alert_channel_victorops" {
    count   = "${var.newrelic_alert_channel_victorops && var.newrelic_alert_channel ? 1 : 0}"

    name    = "${var.newrelic_alert_channel_victorops_name_custom !="" ? var.newrelic_alert_channel_victorops_name_custom : "${lower(var.name)}-nr-channel-victorops-${lower(var.environment)}" }"
    type    = "victorops"

    configuration = {
        key         = "${var.newrelic_alert_channel_victorops_configuration_key}"
        route_key   = "${var.newrelic_alert_channel_victorops_configuration_route_key}"
    }

    lifecycle = {
        create_before_destroy   = true,
        ignore_changes          = []
    }

    depends_on  = []

}

#webhook
resource "newrelic_alert_channel" "alert_channel_webhook" {
    count   = "${var.newrelic_alert_channel_webhook && var.newrelic_alert_channel ? 1 : 0}"

    name    = "${var.newrelic_alert_channel_webhook_name_custom !="" ? var.newrelic_alert_channel_webhook_name_custom : "${lower(var.name)}-nr-channel-webhook-${lower(var.environment)}" }"
    type    = "webhook"

    configuration = {
        auth_password           = "${var.newrelic_alert_channel_webhook_configuration_auth_password}"
        auth_type               = "${var.newrelic_alert_channel_webhook_configuration_auth_type}"
        auth_username           = "${var.newrelic_alert_channel_webhook_configuration_auth_username}"
        base_url                = "${var.newrelic_alert_channel_webhook_configuration_base_url}"
        headers                 = "${var.newrelic_alert_channel_webhook_configuration_headers}"
        payload_type            = "${var.newrelic_alert_channel_webhook_configuration_payload_type}"
        payload                 = "${var.newrelic_alert_channel_webhook_configuration_payload}"
    }

    lifecycle = {
        create_before_destroy   = true,
        ignore_changes          = []
    }

    depends_on  = []

}

