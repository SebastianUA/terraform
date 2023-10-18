#---------------------------------------------------
# Data external
#---------------------------------------------------
data "external" "itself" {
  program = var.external_program

  query       = var.external_query
  working_dir = var.external_working_dir
}