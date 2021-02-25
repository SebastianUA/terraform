// #---------------------------------------------------
// # AWS config conformance pack
// #---------------------------------------------------
// resource "aws_config_conformance_pack" "config_conformance_pack" {
//   count = var.enable_config_conformance_pack ? 1 : 0

//   name = var.config_conformance_pack_name != "" ? lower(var.config_conformance_pack_name) : "${lower(var.name)}-config-conformance-pack-${lower(var.environment)}"

//   delivery_s3_bucket     = var.config_conformance_pack_delivery_s3_bucket
//   delivery_s3_key_prefix = var.config_conformance_pack_delivery_s3_key_prefix

//   template_body   = var.config_conformance_pack_template_body
//   template_s3_uri = var.config_conformance_pack_template_s3_uri

//   dynamic "input_parameter" {
//     iterator = input_parameter
//     for_each = var.config_conformance_pack_input_parameter
//     content {
//       parameter_name  = lookup(input_parameter.value, "parameter_name", null)
//       parameter_value = lookup(input_parameter.value, "parameter_value", null)
//     }
//   }

//   lifecycle {
//     create_before_destroy = true
//     ignore_changes        = []
//   }

//   depends_on = []
// }
