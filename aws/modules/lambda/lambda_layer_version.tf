#---------------------------------------------------
# AWS lambda layer version
#---------------------------------------------------
resource "aws_lambda_layer_version" "lambda_layer_version" {
    count                       = var.enable_lambda_layer_version ? 1 : 0

    layer_name                  = var.lambda_layer_version_layer_name != "" ? var.lambda_layer_version_layer_name : "${lower(var.name)}-lambda-layer-ver-${lower(var.environment)}"

    filename                    = var.lambda_layer_version_filename
    compatible_runtimes         = var.lambda_layer_version_compatible_runtimes

    s3_bucket                   = var.lambda_layer_version_s3_bucket
    s3_key                      = var.lambda_layer_version_s3_key
    s3_object_version           = var.lambda_layer_version_s3_object_version
    description                 = var.lambda_layer_version_description
    license_info                = var.lambda_layer_version_license_info
    source_code_hash            = var.lambda_layer_version_source_code_hash

    lifecycle {
        create_before_destroy   = true
        ignore_changes          = []
    }

    depends_on                  = []
}
