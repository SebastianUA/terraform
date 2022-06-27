#
# MAINTAINER Vitaliy Natarov "vitaliy.natarov@yahoo.com"
#
terraform {
  required_version = "~> 1.0"
}


module "local_file" {
  source = "../../modules/file"

  # Generate ramdom UUID
  enable_file   = true
  file_filename = "file_name.txt"

  file_content              = "bla bla bla"
  file_file_permission      = 0777
  file_directory_permission = 0777
}
