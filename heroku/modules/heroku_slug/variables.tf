#---------------------------------------------------
# Global
#---------------------------------------------------
variable "name" {
  description = "Set name if some variables will be unset for resources"
  default     = "heroku"
}

variable "environment" {
  description = "Set Env name"
  default     = "dev"
}

#---------------------------------------------------
# Heroku slug
#---------------------------------------------------
variable "enable_slug" {
  description = "Enable Heroku slug usage"
  default     = false
}

variable "slug_app" {
  description = "(Required) The ID of the Heroku app"
  default     = null
}

variable "slug_process_types" {
  description = "(Required) Map of processes to launch on Heroku Dynos"
  default     = null
}

variable "slug_stack" {
  description = "Name or ID of the Heroku stack"
  default     = ""
}

variable "slug_buildpack_provided_description" {
  description = "Description of language or app framework, 'Ruby/Rack'; displayed as the app's language in the Heroku Dashboard"
  default     = null
}

variable "slug_checksum" {
  description = "Hash of the slug for verifying its integrity, auto-generated from contents of file_path or file_url, SHA256:e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855"
  default     = null
}

variable "slug_commit" {
  description = "Identification of the code with your version control system (eg: SHA of the git HEAD), '60883d9e8947a57e04dc9124f25df004866a2051'"
  default     = null
}

variable "slug_commit_description" {
  description = "Description of the provided commit"
  default     = null
}

variable "slug_file_path" {
  description = "(Required unless file_url is set) Local path to a slug archive, 'slugs/current.tgz'"
  default     = null
}

variable "slug_file_url" {
  description = "(Required unless file_path is set) https URL to a slug archive, 'https://example.com/slugs/app-v1.tgz'"
  default     = null
}
