#-----------------------------------------------------------
# Azure lb
#-----------------------------------------------------------
output "lb_id" {
  description = "The Load Balancer ID."
  value       = element(concat(azurerm_lb.lb.*.id, [""]), 0)
}

output "lb_frontend_ip_configuration" {
  description = "A frontend_ip_configuration block as documented"
  value       = azurerm_lb.lb.*.frontend_ip_configuration
}

output "lb_private_ip_address" {
  description = "The first private IP address assigned to the load balancer in frontend_ip_configuration blocks, if any."
  value       = element(concat(azurerm_lb.lb.*.private_ip_address, [""]), 0)
}

output "lb_private_ip_addresses" {
  description = "The list of private IP address assigned to the load balancer in frontend_ip_configuration blocks, if any."
  value       = concat(azurerm_lb.lb.*.private_ip_addresses, [""])
}

#-----------------------------------------------------------
# Azure lb rule
#-----------------------------------------------------------
output "lb_rule_id" {
  description = "The ID of the Load Balancer Rule."
  value       = element(concat(azurerm_lb_rule.lb_rule.*.id, [""]), 0)
}

#-----------------------------------------------------------
# Azure lb probe
#-----------------------------------------------------------
output "lb_probe_id" {
  description = "The ID of the Load Balancer Rule."
  value       = element(concat(azurerm_lb_probe.lb_probe.*.id, [""]), 0)
}

#-----------------------------------------------------------
# Azure lb outbound rule
#-----------------------------------------------------------
output "lb_outbound_rule_id" {
  description = "The ID of the Load Balancer Outbound Rule."
  value       = element(concat(azurerm_lb_outbound_rule.lb_outbound_rule.*.id, [""]), 0)
}

#-----------------------------------------------------------
# Azure lb nat rule
#-----------------------------------------------------------
output "lb_nat_rule_id" {
  description = "The ID of the Load Balancer NAT Rule."
  value       = element(concat(azurerm_lb_nat_rule.lb_nat_rule.*.id, [""]), 0)
}

#-----------------------------------------------------------
# Azure lb nat pool
#-----------------------------------------------------------
output "lb_nat_pool_id" {
  description = "The ID of the Load Balancer NAT pool."
  value       = element(concat(azurerm_lb_nat_pool.lb_nat_pool.*.id, [""]), 0)
}

#-----------------------------------------------------------
# Azure lb backend address pool
#-----------------------------------------------------------
output "lb_backend_address_pool_id" {
  description = "The ID of the Backend Address Pool."
  value       = element(concat(azurerm_lb_backend_address_pool.lb_backend_address_pool.*.id, [""]), 0)
}

output "lb_backend_address_pool_backend_ip_configurations" {
  description = "The Backend IP Configurations associated with this Backend Address Pool."
  value       = element(concat(azurerm_lb_backend_address_pool.lb_backend_address_pool.*.backend_ip_configurations, [""]), 0)
}

output "lb_backend_address_pool_load_balancing_rules" {
  description = "The Load Balancing Rules associated with this Backend Address Pool."
  value       = element(concat(azurerm_lb_backend_address_pool.lb_backend_address_pool.*.load_balancing_rules, [""]), 0)
}

output "lb_backend_address_pool_outbound_rules" {
  description = "An array of the Load Balancing Outbound Rules associated with this Backend Address Pool."
  value       = element(concat(azurerm_lb_backend_address_pool.lb_backend_address_pool.*.outbound_rules, [""]), 0)
}

#-----------------------------------------------------------
# Azure lb backend address pool address
#-----------------------------------------------------------
output "lb_backend_address_pool_address_id" {
  description = "The ID of the Backend Address Pool Address."
  value       = element(concat(azurerm_lb_backend_address_pool_address.lb_backend_address_pool_address.*.id, [""]), 0)
}