#---------------------------------------------------
# AWS servicecatalog portfolio
#---------------------------------------------------
resource "aws_servicecatalog_portfolio" "servicecatalog_portfolio" {
  count = var.enable_servicecatalog_portfolio ? 1 : 0

  name          = var.servicecatalog_portfolio_name != "" ? lower(var.servicecatalog_portfolio_name) : "servicecatalog-portfolio"
  description   = var.servicecatalog_portfolio_description != "" ? lower(var.servicecatalog_portfolio_description) : "servicecatalog portfolio that manages by Terraform"
  provider_name = var.servicecatalog_portfolio_provider_name

  tags = merge(
    {
      "Name" = var.servicecatalog_portfolio_name != "" ? lower(var.servicecatalog_portfolio_name) : "servicecatalog-portfolio"
    },
    var.tags
  )

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}
