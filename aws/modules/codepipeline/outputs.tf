#---------------------------------------------------
# AWS codepipeline
#---------------------------------------------------
output "codepipeline_id" {
  description = "The codepipeline ID."
  value       = element(concat(aws_codepipeline.codepipeline.*.id, [""]), 0)
}

output "codepipeline_arn" {
  description = "The codepipeline ARN."
  value       = element(concat(aws_codepipeline.codepipeline.*.arn, [""]), 0)
}

#---------------------------------------------------
# AWS codepipeline webhook
#---------------------------------------------------
output "codepipeline_webhook_id" {
  description = "The CodePipeline webhook's ARN."
  value       = element(concat(aws_codepipeline_webhook.codepipeline_webhook.*.id, [""]), 0)
}

output "codepipeline_webhook_url" {
  description = "The CodePipeline webhook's URL. POST events to this endpoint to trigger the target."
  value       = element(concat(aws_codepipeline_webhook.codepipeline_webhook.*.url, [""]), 0)
}
