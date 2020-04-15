#---------------------------------------------------
# AWS Appmesh mesh
#---------------------------------------------------
output "appmesh_mesh_id" {
    description = "The ID of the service mesh."
    value       = element(concat(aws_appmesh_mesh.appmesh_mesh.*.id, [""]), 0)
}

output "appmesh_mesh_arn" {
    description = "The ARN of the service mesh."
    value       = element(concat(aws_appmesh_mesh.appmesh_mesh.*.arn, [""]), 0)
}

output "appmesh_mesh_created_date" {
    description = "The creation date of the service mesh."
    value       = element(concat(aws_appmesh_mesh.appmesh_mesh.*.created_date, [""]), 0)
}

output "appmesh_mesh_last_updated_date" {
    description = "The last update date of the service mesh."
    value       = element(concat(aws_appmesh_mesh.appmesh_mesh.*.last_updated_date, [""]), 0)
}

#---------------------------------------------------
# AWS Appmesh virtual node
#---------------------------------------------------
output "appmesh_virtual_node_id" {
    description = "The ID of the virtual node."
    value       = element(concat(aws_appmesh_virtual_node.appmesh_virtual_node.*.id, [""]), 0)
}

output "appmesh_virtual_node_arn" {
    description = "The ARN of the virtual node."
    value       = element(concat(aws_appmesh_virtual_node.appmesh_virtual_node.*.arn, [""]), 0)
}

output "appmesh_virtual_node_created_date" {
    description = "The creation date of the virtual node."
    value       = element(concat(aws_appmesh_virtual_node.appmesh_virtual_node.*.created_date, [""]), 0)
}

output "appmesh_virtual_node_last_updated_date" {
    description = "The last update date of the virtual node."
    value       = element(concat(aws_appmesh_virtual_node.appmesh_virtual_node.*.last_updated_date, [""]), 0)
}

#---------------------------------------------------
# AWS Appmesh virtual service
#---------------------------------------------------
output "appmesh_virtual_service_id" {
    description = "The ID of the virtual service."
    value       = element(concat(aws_appmesh_virtual_service.appmesh_virtual_service.*.id, [""]), 0)
}

output "appmesh_virtual_service_arn" {
    description = "The ARN of the virtual service."
    value       = element(concat(aws_appmesh_virtual_service.appmesh_virtual_service.*.arn, [""]), 0)
}

output "appmesh_virtual_service_created_date" {
    description = "The creation date of the virtual service."
    value       = element(concat(aws_appmesh_virtual_service.appmesh_virtual_service.*.created_date, [""]), 0)
}

output "appmesh_virtual_service_last_updated_date" {
    description = "The last update date of the virtual service."
    value       = element(concat(aws_appmesh_virtual_service.appmesh_virtual_service.*.last_updated_date, [""]), 0)
}

#---------------------------------------------------
# AWS Appmesh virtual router
#---------------------------------------------------
output "appmesh_virtual_router_id" {
    description = "The ID of the virtual router."
    value       = element(concat(aws_appmesh_virtual_router.appmesh_virtual_router.*.id, [""]), 0)
}

output "appmesh_virtual_router_arn" {
    description = "The ARN of the virtual router."
    value       = element(concat(aws_appmesh_virtual_router.appmesh_virtual_router.*.arn, [""]), 0)
}

output "appmesh_virtual_router_created_date" {
    description = "The creation date of the virtual router."
    value       = element(concat(aws_appmesh_virtual_router.appmesh_virtual_router.*.created_date, [""]), 0)
}

output "appmesh_virtual_router_last_updated_date" {
    description = "The last update date of the virtual router."
    value       = element(concat(aws_appmesh_virtual_router.appmesh_virtual_router.*.last_updated_date, [""]), 0)
}

#---------------------------------------------------
# AWS Appmesh route
#---------------------------------------------------
output "appmesh_route_id" {
    description = "The ID of the route."
    value       = element(concat(aws_appmesh_route.appmesh_route.*.id, [""]), 0)
}

output "appmesh_route_arn" {
    description = "The ARN of the route."
    value       = element(concat(aws_appmesh_route.appmesh_route.*.arn, [""]), 0)
}

output "appmesh_route_created_date" {
    description = "The creation date of the route."
    value       = element(concat(aws_appmesh_route.appmesh_route.*.created_date, [""]), 0)
}

output "appmesh_route_last_updated_date" {
    description = "The last update date of the route."
    value       = element(concat(aws_appmesh_route.appmesh_route.*.last_updated_date, [""]), 0)
}
