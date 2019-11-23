#
# https://github.com/cerbo/aws-waf-security-automation
#
# https://dev.classmethod.jp/cloud/aws/terraform-supports-aws-waf-in-v-0-7-8/    
#
#---------------------------------------------------
# Create AWS WAF ipset
#---------------------------------------------------
resource "aws_waf_ipset" "waf_ipset" {
    count   = "${var.ip_set_descriptors_value !="" ? 1 : 0}"

    name    = "${lower(var.name)}-ipset-${lower(var.environment)}"
    
    ip_set_descriptors {
        type  = "${var.ip_set_descriptors_type}"
        value = "${var.ip_set_descriptors_value}"
    }
    lifecycle {
        ignore_changes = ["ip_set_descriptors"]
    }
}
#---------------------------------------------------
# Create AWS wafregional ipset
#---------------------------------------------------
resource "aws_wafregional_ipset" "wafregional_ipset" {
    count   = "${var.ip_set_descriptors_value !="" && var.enable_cloudfront_else_alb ? 0 : 1}"

    name    = "${lower(var.name)}-wafregional-ipset-${lower(var.environment)}"
    ip_set_descriptor {
        type = "${var.ip_set_descriptors_type}"
        value = "${var.ip_set_descriptors_value}"
    }
    lifecycle {
        ignore_changes = ["ip_set_descriptors"]
    }
}
#---------------------------------------------------
# Create AWS WAF rules
#---------------------------------------------------
resource "aws_waf_rule" "waf_rule" {
    count       = "${var.ip_set_descriptors_value !="" ? 1 : 0}"
    name        = "${lower(var.name)}-${var.waf_rule_metric_name}-rule-${lower(var.environment)}"
    metric_name = "${var.waf_rule_metric_name}"

    predicates {
        data_id = "${aws_waf_ipset.waf_ipset.id}"
        negated = "${var.waf_rule_predicates_negated}"
        type    = "${var.waf_rule_predicates_type}"
    }

    depends_on  = ["aws_waf_ipset.waf_ipset"]
}
#---------------------------------------------------
# Create AWS WAF rate based rule
#---------------------------------------------------
resource "aws_waf_rate_based_rule" "waf_rate_based_rule" {
    count       = "${var.waf_rate_based_rule_rate_limit !="2000" && var.ip_set_descriptors_value !="" ? 1 : 0}"

    name        = "${lower(var.name)}-${var.waf_rule_metric_name}-rate-based-rule-${lower(var.environment)}"
    metric_name = "${var.waf_rule_metric_name}"

    rate_key    = "${var.waf_rate_based_rule_rate_key}"
    rate_limit  = "${var.waf_rate_based_rule_rate_limit}"

    predicates {
        data_id = "${aws_waf_ipset.waf_ipset.id}"
        negated = "${var.waf_rule_predicates_negated}"
        type    = "${var.waf_rule_predicates_type}"
    }

    depends_on  = ["aws_waf_ipset.waf_ipset"]
}
#---------------------------------------------------
# Create AWS WAF byte match set
#---------------------------------------------------
resource "aws_waf_byte_match_set" "waf_byte_match_set" {
    count   = "${var.byte_match_tuples_target_string !="" ? 1 : 0}"    

    name    = "${lower(var.name)}-byte_match_set-${lower(var.environment)}"
    byte_match_tuples {                         
        text_transformation   = "${var.byte_match_tuples_text_transformation}"
        target_string         = "${var.byte_match_tuples_target_string}"
        positional_constraint = "${var.byte_match_tuples_positional_constraint}"

        field_to_match {
            type = "${var.waf_byte_match_set_field_to_match_type}"
            data = "${var.waf_byte_match_set_field_to_match_data}"
        }
    }
}
#---------------------------------------------------
# Create AWS wafregional byte match set
#---------------------------------------------------
resource "aws_wafregional_byte_match_set" "wafregional_byte_match_set" {
    count   = "${var.ip_set_descriptors_value !="" && var.enable_cloudfront_else_alb ? 0 : 1}"

    name    = "${lower(var.name)}-wafregional-byte_match_set-${lower(var.environment)}"
    byte_match_tuple {
        text_transformation     = "${var.byte_match_tuples_text_transformation}"
        target_string           = "${var.byte_match_tuples_target_string}"
        positional_constraint   = "${var.byte_match_tuples_positional_constraint}"
        field_to_match {
            type = "${var.waf_byte_match_set_field_to_match_type}"
            data = "${var.waf_byte_match_set_field_to_match_data}"
        }
    }
}
#---------------------------------------------------
# Create AWS WAF size constraint set 
#---------------------------------------------------
resource "aws_waf_size_constraint_set" "waf_size_constraint_set" {
    count   = "${var.byte_match_tuples_target_string !="" && var.size_constraint_set_field_to_match_data !="" ? 1 : 0}"

    name    = "${lower(var.name)}-size-constraint-set-${lower(var.environment)}"
    size_constraints {
        text_transformation = "${var.size_constraints_text_transformation}"
        comparison_operator = "${var.size_constraints_comparison_operator}"
        size                = "${var.size_constraints_size}"

        field_to_match {
            type = "${var.size_constraint_set_field_to_match_type}"
            data = "${var.size_constraint_set_field_to_match_data}"   
        }
    }
}
#---------------------------------------------------
# Create AWS WAF sql injection match set
#---------------------------------------------------
resource "aws_waf_sql_injection_match_set" "waf_sql_injection_match_set" {
    count   = "${var.ip_set_descriptors_value !="" ? 1 : 0}"  

    name    = "${lower(var.name)}-sql-injection-match-set-${lower(var.environment)}"
    sql_injection_match_tuples {
        text_transformation = "URL_DECODE"
        field_to_match {
          type = "QUERY_STRING"
          data = "none"
        }
    }
    sql_injection_match_tuples {
        text_transformation = "HTML_ENTITY_DECODE"
        field_to_match {
          type = "QUERY_STRING"
          data = "none"
        }
    }
    sql_injection_match_tuples {
        text_transformation = "URL_DECODE"
        field_to_match {
          type = "BODY"
          data = "none"
        }
    }
    sql_injection_match_tuples {
        text_transformation = "HTML_ENTITY_DECODE"
        field_to_match {
          type = "BODY"
          data = "none"
        }
    }
    sql_injection_match_tuples {
        text_transformation = "URL_DECODE"
        field_to_match {
          type = "URI"
          data = "none"
        }
    }
    sql_injection_match_tuples {
        text_transformation = "HTML_ENTITY_DECODE"
        field_to_match {
          type = "URI"
          data = "none"
        }
    }    
}
#---------------------------------------------------
# Create AWS WAF xss match set
#---------------------------------------------------
resource "aws_waf_xss_match_set" "waf_xss_match_set" {
    count   = "${var.ip_set_descriptors_value !="" ? 1 : 0}"  

    name = "${lower(var.name)}-xss-match-set-${lower(var.environment)}"
    xss_match_tuples {
        text_transformation = "URL_DECODE"
        field_to_match {
            type = "QUERY_STRING"
            data = "none"
        }
    }
    xss_match_tuples {
        text_transformation = "HTML_ENTITY_DECODE"
        field_to_match {
            type = "QUERY_STRING"
            data = "none"
        }
    }
    xss_match_tuples {
        text_transformation = "URL_DECODE"
        field_to_match {
            type = "BODY"
            data = "none"
        }
    }
    xss_match_tuples {
        text_transformation = "HTML_ENTITY_DECODE"
        field_to_match {
            type = "BODY"
            data = "none"
        }
    }
    xss_match_tuples {
        text_transformation = "URL_DECODE"
        field_to_match {
            type = "URI"
            data = "none"
        }
    }
    xss_match_tuples {
        text_transformation = "HTML_ENTITY_DECODE"
        field_to_match {
            type = "URI"
            data = "none"
        }
    }
}
#---------------------------------------------------
# Create AWS WAF web acl
#---------------------------------------------------
resource "aws_waf_web_acl" "waf_web_acl" {
    count       = "${var.ip_set_descriptors_value !="" ? 1 : 0}"
            
    name        = "${lower(var.name)}-waf-web-acl-${lower(var.environment)}"
    metric_name = "${var.waf_web_acl_metric_name}"

    default_action {
        type = "${var.waf_web_acl_default_action_type}"
    }

    rules {
        action {
            type = "${var.waf_web_acl_rules_action_type}"
        }

        priority = "${var.waf_web_acl_rules_priority}"
        rule_id  = "${aws_waf_rule.waf_rule.id}"
        type     = "${var.waf_web_acl_rules_type}"
    }
    
    depends_on  = ["aws_waf_ipset.waf_ipset", "aws_waf_rule.waf_rule"]
}
