#---------------------------------------------------
# AWS datapipeline pipeline
#---------------------------------------------------
output "datapipeline_pipeline_id" {
    description = "The identifier of the client certificate."
    value       = element(concat(aws_datapipeline_pipeline.datapipeline_pipeline.*.id, [""], ), 0)
}
