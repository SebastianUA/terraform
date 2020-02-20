#---------------------------------------------------
# AWS WAF byte match set
#---------------------------------------------------
resource "aws_waf_byte_match_set" "waf_byte_match_set" {
    count           = var.enable_waf_byte_match_set ? 1 : 0

    name            = var.waf_byte_match_set_name != "" ? lower(var.waf_byte_match_set_name) : "${lower(var.name)}-byte-match-set-${lower(var.environment)}"
    
    byte_match_tuples {                         
        text_transformation   = upper(var.byte_match_tuples_text_transformation)
        target_string         = var.byte_match_tuples_target_string
        positional_constraint = upper(var.byte_match_tuples_positional_constraint)

        field_to_match {
            type = upper(var.waf_byte_match_set_field_to_match_type)
            data = var.waf_byte_match_set_field_to_match_data
        }
    }

    lifecycle {
        create_before_destroy   = true
        ignore_changes          = []
    }
                     
    depends_on      = []
}