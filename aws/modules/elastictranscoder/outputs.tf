#---------------------------------------------------
# AWS elastictranscoder pipeline
#---------------------------------------------------
output "elastictranscoder_pipeline_id" {
  description = "ID of elastictranscoder pipeline"
  value       = element(concat(aws_elastictranscoder_pipeline.elastictranscoder_pipeline.*.id, [""]), 0)
}

#---------------------------------------------------
# AWS elastictranscoder preset
#---------------------------------------------------
output "elastictranscoder_preset_id" {
  description = "ID of elastictranscoder preset"
  value       = element(concat(aws_elastictranscoder_preset.elastictranscoder_preset.*.id, [""]), 0)
}
