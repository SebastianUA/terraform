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

    lifecycle {
        create_before_destroy   = true
        ignore_changes          = []
    }

    depends_on                  = []
}
