#---------------------------------------------------
# AWS accessanalyzer analyzer
#---------------------------------------------------
resource "aws_accessanalyzer_analyzer" "accessanalyzer_analyzer" {
  count = var.enable_accessanalyzer_analyzer ? 1 : 0

  analyzer_name = var.accessanalyzer_analyzer_name != "" ? var.accessanalyzer_analyzer_name : "${lower(var.name)}-accessanalyzer-analyzer-${lower(var.environment)}"

  type = upper(var.accessanalyzer_analyzer_type)

  tags = merge(
    {
      Name = var.accessanalyzer_analyzer_name != "" ? var.accessanalyzer_analyzer_name : "${lower(var.name)}-accessanalyzer-analyzer-${lower(var.environment)}"
    },
    var.tags
  )

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}
