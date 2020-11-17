#---------------------------------------------------
# AWS accessanalyzer analyzer
#---------------------------------------------------
output "accessanalyzer_analyzer_id" {
  description = "Analyzer name."
  value       = element(concat(aws_accessanalyzer_analyzer.accessanalyzer_analyzer.*.id, [""]), 0)
}
