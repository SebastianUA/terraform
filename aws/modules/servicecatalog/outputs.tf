#---------------------------------------------------
# AWS servicecatalog portfolio
#---------------------------------------------------
output "servicecatalog_portfolio_id" {
    description = "The ID of the Service Catalog Portfolio."
    value       = element(concat(aws_servicecatalog_portfolio.servicecatalog_portfolio.*.id, [""]), 0)
}
