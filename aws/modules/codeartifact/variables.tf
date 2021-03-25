#-----------------------------------------------------------
# Global or/and default variables
#-----------------------------------------------------------
variable "name" {
  description = "Name to be used on all resources as prefix"
  default     = "TEST"
}

variable "environment" {
  description = "Environment for service"
  default     = "STAGE"
}

variable "tags" {
  description = "A list of tag blocks. Each element should have keys named key, value, etc."
  type        = map(string)
  default     = {}
}

#---------------------------------------------------
# AWS CodeArtifact domain
#---------------------------------------------------
variable "enable_codeartifact_domain" {
  description = "Enable codeartifact domain usage"
  default     = false
}

variable "codeartifact_domain" {
  description = "The name of the domain to create. All domain names in an AWS Region that are in the same AWS account must be unique. The domain name is used as the prefix in DNS hostnames. Do not use sensitive information in a domain name because it is publicly discoverable."
  default     = ""
}

variable "codeartifact_domain_encryption_key" {
  description = "(Optional) The encryption key for the domain. This is used to encrypt content stored in a domain. The KMS Key Amazon Resource Name (ARN). The default aws/codeartifact AWS KMS master key is used if this element is absent."
  default     = null
}

#---------------------------------------------------
# AWS CodeArtifact domain permissions policy
#---------------------------------------------------
variable "enable_codeartifact_domain_permissions_policy" {
  description = "Enable codeartifact domain permissions policy usage"
  default     = false
}

variable "codeartifact_domain_permissions_policy_domain" {
  description = "The name of the domain on which to set the resource policy."
  default     = ""
}

variable "codeartifact_domain_permissions_policy_document" {
  description = "(Required) A JSON policy string to be set as the access control resource policy on the provided domain."
  default     = null
}

variable "codeartifact_domain_permissions_policy_domain_owner" {
  description = "(Optional) The account number of the AWS account that owns the domain."
  default     = null
}

variable "codeartifact_domain_permissions_policy_revision" {
  description = "(Optional) The current revision of the resource policy to be set. This revision is used for optimistic locking, which prevents others from overwriting your changes to the domain's resource policy."
  default     = null
}

#---------------------------------------------------
# AWS CodeArtifact repository
#---------------------------------------------------
variable "enable_codeartifact_repository" {
  description = "Enable codeartifact repository usage"
  default     = false
}

variable "codeartifact_repository" {
  description = "The name of the repository to create."
  default     = ""
}

variable "codeartifact_repository_domain" {
  description = "The domain that contains the created repository."
  default     = ""
}

variable "codeartifact_repository_description" {
  description = "(Optional) The description of the repository."
  default     = null
}

variable "codeartifact_repository_domain_owner" {
  description = "(Optional) The account number of the AWS account that owns the domain."
  default     = null
}

variable "codeartifact_repository_upstream" {
  description = "(Optional) A list of upstream repositories to associate with the repository. The order of the upstream repositories in the list determines their priority order when AWS CodeArtifact looks for a requested package version. see Upstream"
  default     = []
}

variable "codeartifact_repository_external_connections" {
  description = "An array of external connections associated with the repository. Only one external connection can be set per repository. see External Connections."
  default     = []
}

#---------------------------------------------------
# AWS CodeArtifact repository permissions policy
#---------------------------------------------------
variable "enable_codeartifact_repository_permissions_policy" {
  description = "Enable codeartifact repository permissions policy usage"
  default     = false
}

variable "codeartifact_repository_permissions_policy_repository" {
  description = "The name of the repository to set the resource policy on."
  default     = ""
}

variable "codeartifact_repository_permissions_policy_domain" {
  description = "The name of the domain on which to set the resource policy."
  default     = "codeartifact_repository_permissions_policy_repository"
}

variable "codeartifact_repository_permissions_policy_document" {
  description = "(Required) A JSON policy string to be set as the access control resource policy on the provided domain."
  default     = null
}

variable "codeartifact_repository_permissions_policy_domain_owner" {
  description = "(Optional) The account number of the AWS account that owns the domain."
  default     = null
}

variable "codeartifact_repository_permissions_policy_policy_revision" {
  description = "(Optional) The current revision of the resource policy to be set. This revision is used for optimistic locking, which prevents others from overwriting your changes to the domain's resource policy."
  default     = null
}