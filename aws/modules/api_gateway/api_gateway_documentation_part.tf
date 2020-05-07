#---------------------------------------------------
# AWS API Gateway documentation part
#---------------------------------------------------
resource "aws_api_gateway_documentation_part" "api_gateway_documentation_part" {
    count               = var.enable_api_gateway_documentation_part ? 1 : 0

    rest_api_id         = var.api_gateway_documentation_part_rest_api_id != "" && !var.enable_api_gateway_rest_api ? var.api_gateway_documentation_part_rest_api_id : element(concat(aws_api_gateway_rest_api.api_gateway_rest_api.*.id, [""]), 0)
    properties          = var.api_gateway_documentation_part_properties

    location {
        type            = upper(var.api_gateway_documentation_part_location_type)

        method          = var.api_gateway_documentation_part_location_method
        name            = var.api_gateway_documentation_part_location_name
        path            = var.api_gateway_documentation_part_location_path
        status_code     = var.api_gateway_documentation_part_location_status_code
    }

    lifecycle {
        create_before_destroy   = true
        ignore_changes          = []
    }

    depends_on          = [
        aws_api_gateway_rest_api.api_gateway_rest_api
    ]
}
