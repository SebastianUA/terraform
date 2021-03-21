output "glue_crawler_name" {
  value = module.glue.glue_crawler_id
}

output "glue_job_name" {
  value = module.glue.glue_job_id
}

output "random_glue_connection_password" {
  value = module.random_glue_connection_password.password_result
}
