#-----------------------------------------------------------
# Azure kubernetes cluster
#-----------------------------------------------------------
output "kubernetes_cluster_id" {
  description = "The Kubernetes Managed Cluster ID."
  value       = element(concat(azurerm_kubernetes_cluster.kubernetes_cluster.*.id, [""]), 0)
}

output "kubernetes_cluster_fqdn" {
  description = "The FQDN of the Azure Kubernetes Managed Cluster."
  value       = element(concat(azurerm_kubernetes_cluster.kubernetes_cluster.*.fqdn, [""]), 0)
}

output "kubernetes_cluster_private_fqdn" {
  description = "The FQDN for the Kubernetes Cluster when private link has been enabled, which is only resolvable inside the Virtual Network used by the Kubernetes Cluster."
  value       = element(concat(azurerm_kubernetes_cluster.kubernetes_cluster.*.private_fqdn, [""]), 0)
}

output "kubernetes_cluster_portal_fqdn" {
  description = "The FQDN for the Azure Portal resources when private link has been enabled, which is only resolvable inside the Virtual Network used by the Kubernetes Cluster."
  value       = element(concat(azurerm_kubernetes_cluster.kubernetes_cluster.*.portal_fqdn, [""]), 0)
}

output "kubernetes_cluster_kube_admin_config" {
  description = "A kube_admin_config block. This is only available when Role Based Access Control with Azure Active Directory is enabled and local accounts enabled."
  value       = concat(azurerm_kubernetes_cluster.kubernetes_cluster.*.kube_admin_config, [""])
}

output "kubernetes_cluster_kube_admin_config_raw" {
  description = "Raw Kubernetes config for the admin account to be used by kubectl and other compatible tools. This is only available when Role Based Access Control with Azure Active Directory is enabled and local accounts enabled."
  value       = concat(azurerm_kubernetes_cluster.kubernetes_cluster.*.kube_admin_config_raw, [""])
}

output "kubernetes_cluster_kube_config" {
  description = "A kube_config block as defined"
  value       = concat(azurerm_kubernetes_cluster.kubernetes_cluster.*.kube_config, [""])
}

output "kubernetes_cluster_kube_config_raw" {
  description = "Raw Kubernetes config to be used by kubectl and other compatible tools."
  value       = concat(azurerm_kubernetes_cluster.kubernetes_cluster.*.kube_config_raw, [""])
}

output "kubernetes_cluster_http_application_routing_zone_name" {
  description = "The Zone Name of the HTTP Application Routing."
  value       = element(concat(azurerm_kubernetes_cluster.kubernetes_cluster.*.http_application_routing_zone_name, [""]), 0)
}

output "kubernetes_cluster_oidc_issuer_url" {
  description = "The OIDC issuer URL that is associated with the cluster."
  value       = element(concat(azurerm_kubernetes_cluster.kubernetes_cluster.*.oidc_issuer_url, [""]), 0)
}

output "kubernetes_cluster_node_resource_group" {
  description = "The auto-generated Resource Group which contains the resources for this Managed Kubernetes Cluster."
  value       = element(concat(azurerm_kubernetes_cluster.kubernetes_cluster.*.node_resource_group, [""]), 0)
}

output "kubernetes_cluster_load_balancer_profile" {
  description = "load balancer profile"
  value       = concat(azurerm_kubernetes_cluster.kubernetes_cluster.*.load_balancer_profile, [""])
}

output "kubernetes_cluster_nat_gateway_profile" {
  description = "nat gateway profile"
  value       = concat(azurerm_kubernetes_cluster.kubernetes_cluster.*.nat_gateway_profile, [""])
}

output "kubernetes_cluster_identity" {
  description = "An identity block"
  value       = concat(azurerm_kubernetes_cluster.kubernetes_cluster.*.identity, [""])
}

output "kubernetes_cluster_ingress_application_gateway" {
  description = "The ingress_application_gateway block"
  value       = concat(azurerm_kubernetes_cluster.kubernetes_cluster.*.ingress_application_gateway, [""])
}

output "kubernetes_cluster_oms_agent" {
  description = "The oms_agent block"
  value       = concat(azurerm_kubernetes_cluster.kubernetes_cluster.*.oms_agent, [""])
}

output "kubernetes_cluster_oms_agent_identity" {
  description = "The oms_agent_identity block"
  value       = concat(azurerm_kubernetes_cluster.kubernetes_cluster.*.oms_agent_identity, [""])
}

output "kubernetes_cluster_key_vault_secrets_provider" {
  description = "The key_vault_secrets_provider block"
  value       = concat(azurerm_kubernetes_cluster.kubernetes_cluster.*.key_vault_secrets_provider, [""])
}

output "kubernetes_cluster_secret_identity" {
  description = "The secret_identity block"
  value       = concat(azurerm_kubernetes_cluster.kubernetes_cluster.*.secret_identity, [""])
}


#-----------------------------------------------------------
# Azure kubernetes cluster node pool
#-----------------------------------------------------------
output "kubernetes_cluster_node_pool_id" {
  description = "The ID of the Kubernetes Cluster Node Pool."
  value       = concat(azurerm_kubernetes_cluster_node_pool.kubernetes_cluster_node_pool.*.id, [""])
}
