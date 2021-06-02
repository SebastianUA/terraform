locals {
  vpc_endpoint_stack_gtw = toset(compact(
    [for k, v in var.vpc_endpoint_stack : var.vpc_endpoint_stack[k].vpc_endpoint_type == "Gateway" ? k : ""]
  ))
}

output "locals" {
  value = local.vpc_endpoint_stack_gtw
}