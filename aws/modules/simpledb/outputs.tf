#---------------------------------------------------
# AWS simpledb domain
#---------------------------------------------------
output "simpledb_domain_id" {
    description = "The name of the SimpleDB domain"
    value       = element(concat(aws_simpledb_domain.simpledb_domain.*.id, [""]), 0)
}
