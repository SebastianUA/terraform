#-----------------------------------------------------------
# dns steering policy
#-----------------------------------------------------------
resource "oci_dns_steering_policy" "dns_steering_policy" {
  count = var.enable_dns_steering_policy ? 1 : 0

  # Required
  compartment_id = var.dns_steering_policy_compartment_id
  display_name   = var.dns_steering_policy_display_name != "" ? var.dns_steering_policy_display_name : "${lower(var.name)}-dns-steering-policy-${lower(var.environment)}"
  template       = var.dns_steering_policy_template

  # Optional
  health_check_monitor_id = var.dns_steering_policy_health_check_monitor_id
  ttl                     = var.dns_steering_policy_ttl

  dynamic "answers" {
    iterator = answers
    for_each = var.dns_steering_policy_answers

    content {
      # Required
      name  = lookup(answers.value, "name", null)
      rdata = lookup(answers.value, "rdata", null)
      rtype = lookup(answers.value, "rtype", null)

      # Optional
      is_disabled = lookup(answers.value, "is_disabled", null)
      pool        = lookup(answers.value, "pool", null)
    }
  }

  dynamic "rules" {
    iterator = rules
    for_each = var.dns_steering_policy_rules

    content {
      # Required
      rule_type = lookup(rules.value, "rule_type", null)

      # Optional
      default_count = lookup(rules.value, "default_count", null)
      description   = lookup(rules.value, "description", null)

      dynamic "cases" {
        iterator = cases
        for_each = length(keys(lookup(rules.value, "cases", {}))) > 0 ? [lookup(rules.value, "cases", {})] : []

        content {
          # Optional
          dynamic "answer_data" {
            iterator = answer_data
            for_each = length(keys(lookup(cases.value, "answer_data", {}))) > 0 ? [lookup(cases.value, "answer_data", {})] : []

            content {

              #Optional
              answer_condition = lookup(answer_data.value, "answer_condition", null)
              should_keep      = lookup(answer_data.value, "should_keep", null)
              value            = lookup(answer_data.value, "value", null)
            }
          }
          case_condition = lookup(cases.value, "case_condition", null)
          count          = lookup(cases.value, "count", null)
        }
      }

      dynamic "default_answer_data" {
        iterator = default_answer_data
        for_each = length(keys(lookup(rules.value, "default_answer_data", {}))) > 0 ? [lookup(rules.value, "default_answer_data", {})] : []

        content {
          # Optional
          answer_condition = lookup(default_answer_data.value, "answer_condition", null)
          should_keep      = lookup(default_answer_data.value, "should_keep", null)
          value            = lookup(default_answer_data.value, "value", null)
        }
      }
    }
  }

  defined_tags = var.dns_steering_policy_defined_tags
  freeform_tags = merge(
    {
      "Name" = var.dns_steering_policy_display_name != "" ? var.dns_steering_policy_display_name : "${lower(var.name)}-dns-steering-policy-${lower(var.environment)}"
    },
    var.tags
  )

  dynamic "timeouts" {
    iterator = timeouts
    for_each = length(keys(var.dns_steering_policy_timeouts)) > 0 ? [var.dns_steering_policy_timeouts] : []

    content {
      create = lookup(timeouts.value, "create", null)
      update = lookup(timeouts.value, "update", null)
      delete = lookup(timeouts.value, "delete", null)
    }
  }

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}