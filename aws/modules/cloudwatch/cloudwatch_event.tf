#---------------------------------------------------
# Create AWS CloudWatch event permission
#---------------------------------------------------
resource "aws_cloudwatch_event_permission" "cw_event_permission" {
    count           = var.enable_cw_event_permission ? 1 : 0

    principal       = var.cw_event_permission_principal
    statement_id    = var.cw_event_permission_statement_id
    action          = var.cw_event_permission_action

    lifecycle {
        create_before_destroy   = true
        ignore_changes          = []
    }

    depends_on  = []
}
#---------------------------------------------------
# Create AWS CloudWatch event rule
#---------------------------------------------------
resource "aws_cloudwatch_event_rule" "cw_event_rule" {
    count           = var.enable_cw_event_rule ? 1 : 0

    name            = var.cw_event_rule_name != "" ? var.cw_event_rule_name : "${lower(var.name)}-cw_event_rule-${lower(var.environment)}"
    description     = var.cw_event_rule_description != "" ? var.cw_event_rule_description : "${lower(var.name)}-cw_event_rule-${lower(var.environment)}"
    is_enabled      = var.is_enabled_for_event_rule

    event_pattern   = var.cw_event_rule_event_pattern

    lifecycle {
        create_before_destroy   = true
        ignore_changes          = []
    }

    depends_on  = []
}

resource "aws_cloudwatch_event_target" "cw_event_target" {
    count       = var.enbale_cw_event_target ? 1 : 0

    rule        = var.cw_event_rule_name != "" ? var.cw_event_rule_name : element(concat(aws_cloudwatch_event_rule.cw_event_rule.*.name, [""]), 0)
    target_id   = var.cw_event_target_target_id
    arn         = var.cw_event_target_arn

    lifecycle {
        create_before_destroy   = true
        ignore_changes          = []
    }

    depends_on  = []
}
