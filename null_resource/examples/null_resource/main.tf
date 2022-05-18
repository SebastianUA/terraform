#
# MAINTAINER Vitaliy Natarov "vitaliy.natarov@yahoo.com"
#

terraform {
  required_version = "~> 1.0"
}

provider "aws" {
  region                  = "us-east-1"
  shared_credentials_file = pathexpand("~/.aws/credentials")
  profile                 = "default"
  max_retries             = 3
}

module "provisioner_file" {
  source = "../../modules/null_resource"

  enable_provisioner_file      = true
  provisioner_file_source      = "additional_files/provisioner_file.txt"
  provisioner_file_destination = "/home/captain/provisioner_file.txt"

  provisioner_file_connection_type = "ssh"
  provisioner_file_connection_user = "captain"

  # if you wish to use login & password, then use
  # provisioner_file_connection_password       = "password_here"
  # or you can use RSA key to conncetion
  provisioner_file_connection_private_key    = file("/Users/captain/.ssh/id_rsa")
  provisioner_file_connection_agent          = false
  provisioner_file_connection_agent_identity = null
  provisioner_file_connection_host_key       = null

  provisioner_file_connection_host        = "12.17.17.66"
  provisioner_file_connection_port        = 22
  provisioner_file_connection_timeout     = 60
  provisioner_file_connection_script_path = "./additional_files"

}

module "provisioner_local_exec" {
  source = "../../modules/null_resource"

  enable_provisioner_local_exec      = true
  provisioner_local_exec_working_dir = "./additional_files"
  provisioner_local_exec_command     = "pwd && ls -alh ."
  provisioner_local_exec_interpreter = []
  provisioner_local_exec_environment = {
    FOO = "bar"
    BAR = 1
    BAZ = "true"
  }
}

module "provisioner_remote_exec" {
  source = "../../modules/null_resource"

  enable_provisioner_remote_exec_inline = true

  provisioner_remote_exec_connection_type = "ssh"
  provisioner_remote_exec_connection_user = "captain"

  provisioner_remote_exec_inline = ["echo 'its working fine' > /home/captain/provisioner_remote_exec.txt"]
  # provisioner_remote_exec_script                      = "some_script_here.sh"
  # provisioner_remote_exec_scripts                    = ["some_script_here.sh", "some_script_here.sh args"]

  # if you wish to use login & password, then use
  # provisioner_remote_exec_connection_password        = "password_here"
  # or you can use RSA key to conncetion
  provisioner_remote_exec_connection_private_key    = file("/Users/captain/.ssh/id_rsa")
  provisioner_remote_exec_connection_agent          = false
  provisioner_remote_exec_connection_agent_identity = null
  provisioner_remote_exec_connection_host_key       = null

  provisioner_remote_exec_connection_host        = "12.17.17.66"
  provisioner_remote_exec_connection_port        = 22
  provisioner_remote_exec_connection_timeout     = 60
  provisioner_remote_exec_connection_script_path = "./"

}