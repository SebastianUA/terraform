#---------------------------------------------------
# AWS Sagemaker servicecatalog portfolio status
#---------------------------------------------------
resource "aws_sagemaker_servicecatalog_portfolio_status" "sagemaker_servicecatalog_portfolio_status" {
  count = var.enable_sagemaker_servicecatalog_portfolio_status ? 1 : 0


  status = var.sagemaker_servicecatalog_portfolio_status

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}
