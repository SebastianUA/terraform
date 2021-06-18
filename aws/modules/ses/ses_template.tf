#---------------------------------------------------
# AWS ses template
#---------------------------------------------------
resource "aws_ses_template" "ses_template" {
  count = var.enable_ses_template ? 1 : 0

  name = var.ses_template_name != "" ? var.ses_template_name : "${lower(var.name)}-ses-template-${lower(var.environment)}"

  subject = var.ses_template_subject
  html    = var.ses_template_html
  text    = var.ses_template_text

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}