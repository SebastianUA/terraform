output "alb_name" {
  description = "LB name"
  value       = module.alb.lb_name
}

output "alb_tg_name" {
  description = "LB target group name"
  value       = module.alb.lb_tg_name
}
