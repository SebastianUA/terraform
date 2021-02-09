#-----------------------------------------------------------
# Global
#-----------------------------------------------------------
variable "name" {
  description = "The name for resources"
  default     = "test"
}

variable "environment" {
  description = "The environment for resources"
  default     = "dev"
}

#-----------------------------------------------------------
# ArgoCD repository
#-----------------------------------------------------------
variable "enable_repository" {
  description = "Enable argocd repository usage"
  default     = false
}

variable "repository_repo" {
  description = "(Required), string, URL of the repository."
  default     = null
}

variable "repository_name" {
  description = "(Optional), string, only for Helm repositories."
  default     = ""
}

variable "repository_type" {
  description = "(Optional), string, type of the repo, may be 'git' or 'helm'. Defaults to git."
  default     = null
}

variable "repository_insecure" {
  description = "(Optional), boolean, whether to verify the repository TLS certificate."
  default     = null
}

variable "repository_enable_lfs" {
  description = "(Optional), boolean, whether git-lfs support should be enabled for this repository."
  default     = null
}

variable "repository_username" {
  description = "(Optional), string, username to authenticate against the repository server."
  default     = null
}

variable "repository_password" {
  description = "(Optional), string, password to authenticate against the repository server."
  default     = null
}

variable "repository_ssh_private_key" {
  description = "(Optional), string, SSH private key data to authenticate against the repository server. Only for Git repositories."
  default     = null
}

variable "repository_tls_client_cert_data" {
  description = "(Optional), TLS client cert data to authenticate against the repository server."
  default     = null
}

variable "repository_tls_client_cert_key" {
  description = "(Optional), TLS client cert key to authenticate against the repository server."
  default     = null
}

#---------------------------------------------------
# ArgoCD repository credentials
#---------------------------------------------------
variable "enable_repository_credentials" {
  description = "Enable argocd repository credentials usage"
  default     = false
}

variable "repository_credentials_url" {
  description = "(Required), string, URL that these credentials matches to."
  default     = null
}

variable "repository_credentials_username" {
  description = "(Optional), string, username to authenticate against the repository server."
  default     = null
}

variable "repository_credentials_password" {
  description = "(Optional), string, password to authenticate against the repository server."
  default     = null
}

variable "repository_credentials_ssh_private_key" {
  description = "Optional), string, SSH private key data to authenticate against the repository server. Only for Git repositories."
  default     = null
}

variable "repository_credentials_tls_client_cert_data" {
  description = "(Optional), TLS client cert data to authenticate against the repository server."
  default     = null
}

variable "repository_credentials_tls_client_cert_key" {
  description = "(Optional), TLS client cert key to authenticate against the repository server."
  default     = null
}
