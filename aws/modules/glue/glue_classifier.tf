#---------------------------------------------------
# AWS Glue classifier
#---------------------------------------------------
resource "aws_glue_classifier" "glue_classifier" {
  count = var.enable_glue_classifier ? 1 : 0

  name = var.glue_classifier_name != "" ? lower(var.glue_classifier_name) : "${lower(var.name)}-glue-classifier-${lower(var.environment)}"

  dynamic "csv_classifier" {
    iterator = csv_classifier
    for_each = var.glue_classifier_csv_classifier
    content {
      allow_single_column    = lookup(csv_classifier.value, "allow_single_column", null)
      contains_header        = lookup(csv_classifier.value, "contains_header", null)
      delimiter              = lookup(csv_classifier.value, "delimiter", null)
      disable_value_trimming = lookup(csv_classifier.value, "disable_value_trimming", null)
      header                 = lookup(csv_classifier.value, "header", null)
      quote_symbol           = lookup(csv_classifier.value, "quote_symbol", null)
    }
  }

  dynamic "grok_classifier" {
    iterator = grok_classifier
    for_each = var.glue_classifier_grok_classifier
    content {
      classification  = lookup(grok_classifier.value, "classification", null)
      custom_patterns = lookup(grok_classifier.value, "custom_patterns", null)
      grok_pattern    = lookup(grok_classifier.value, "grok_pattern", null)
    }
  }

  dynamic "json_classifier" {
    iterator = json_classifier
    for_each = var.glue_classifier_json_classifier
    content {
      json_path = lookup(json_classifier.value, "json_path", null)
    }
  }

  dynamic "xml_classifier" {
    iterator = xml_classifier
    for_each = var.glue_classifier_xml_classifier
    content {
      classification = lookup(xml_classifier.value, "classification", null)
      row_tag        = lookup(xml_classifier.value, "row_tag", null)
    }
  }

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}
