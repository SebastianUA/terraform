#---------------------------------------------------
# AWS WAF size constraint set 
#---------------------------------------------------
resource "aws_waf_size_constraint_set" "waf_size_constraint_set" {
    count           = var.enable_waf_size_constraint_set ? 1 : 0

    name            = var.waf_size_constraint_set_name != "" ? lower(var.waf_size_constraint_set_name) : "${lower(var.name)}-size-constraint-set-${lower(var.environment)}"
    
    size_constraints {
        text_transformation = upper(var.size_constraints_text_transformation)
        comparison_operator = upper(var.size_constraints_comparison_operator)
        size                = var.size_constraints_size

        field_to_match {
            type = upper(var.size_constraint_set_field_to_match_type)
            data = var.size_constraint_set_field_to_match_data 
        }
    }

    lifecycle {
        create_before_destroy   = true
        ignore_changes          = []
    }
                     
    depends_on      = []
}