#---------------------------------------------------
# Data external
#---------------------------------------------------
output "data_external_result" {
  description = "The result of data external"
  value       = data.external.itself.result
}
