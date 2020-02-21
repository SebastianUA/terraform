#---------------------------------------------------
# AWS WAF regex pattern set
#---------------------------------------------------
resource "aws_waf_regex_pattern_set" "waf_regex_pattern_set" {
    count                   = var.enable_waf_regex_pattern_set ? 1 : 0

    name                    = var.waf_regex_pattern_set_name != "" ? lower(var.waf_regex_pattern_set_name) : "${lower(var.name)}-regex-pattern-set-${lower(var.environment)}"
    regex_pattern_strings   = var.waf_regex_pattern_set_regex_pattern_strings

    lifecycle {
        create_before_destroy   = true
        ignore_changes          = []
    }

    depends_on              = []
}