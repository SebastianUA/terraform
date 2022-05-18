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

#-----------------------------------------------------------
# ProofPoint Meta certificate
#-----------------------------------------------------------
variable "enable_certificate" {
  description = "Enable certificate usage"
  default     = false
}

variable "certificate_name" {
  description = "Set cert name"
  default     = ""
}

variable "certificate_sans" {
  description = "List of certificate SANs"
  default     = []
}

variable "certificate_description" {
  description = "Set certificate description"
  default     = ""
}

#-----------------------------------------------------------
# ProofPoint Meta log streaming access bridge
#-----------------------------------------------------------
variable "enable_log_streaming_access_bridge" {
  description = "Enable log streaming access bridge usage"
  default     = false
}

variable "log_streaming_access_bridge_name" {
  description = "Set log streaming access bridge name"
  default     = ""
}

variable "log_streaming_access_bridge_export_logs" {
  description = "(List of String) Enum: api traffic security metaproxy webfilter"
  default     = []
}

variable "log_streaming_access_bridge_description" {
  description = "Set description"
  default     = ""
}

variable "log_streaming_access_bridge_enabled" {
  description = "Set log streaming access bridge enabled"
  default     = true
}

variable "log_streaming_access_bridge_notification_channels" {
  description = "(List of String) Notification channel IDs to which an alert will be sent if the log streaming service becomes unavailable or the endpoint is unreachable."
  default     = []
}

variable "log_streaming_access_bridge_proofpoint_casb_config" {
  description = "(Block List, Max: 1) Configuration for log streaming to Proofpoint CASB for shadow IT processing."
  default     = {}
}

variable "log_streaming_access_bridge_qradar_http_config" {
  description = "(Block List, Max: 1) Configuration for log streaming to IBM QRadar platform."
  default     = {}
}

variable "log_streaming_access_bridge_s3_config" {
  description = "(Block List, Max: 1) Configuration for log streaming to an Amazon S3 bucket."
  default     = {}
}

variable "log_streaming_access_bridge_splunk_http_config" {
  description = "(Block List, Max: 1) Configuration for log streaming to Self-Hosted / cloud Splunk. see here for instructions on how to enable HTTP Event Collector on Self-Hosted Instance, and here for instructions on how to enable HTTP Event Collector on Cloud Instance."
  default     = {}
}

variable "log_streaming_access_bridge_syslog_config" {
  description = "(Block List, Max: 1) Configuration for log streaming in Syslog Common Event Format (CEF)."
  default     = {}
}

#-----------------------------------------------------------
# ProofPoint Meta role
#-----------------------------------------------------------
variable "enable_role" {
  description = "Enable role usage"
  default     = false
}

variable "role_name" {
  description = "Set role name"
  default     = ""
}

variable "role_description" {
  description = "Set description"
  default     = ""
}

variable "role_all_read_privileges" {
  description = "Set role all read privileges (True, False)"
  default     = false
}

variable "role_all_suborgs" {
  description = "Set all suborgs (True, False)"
  default     = false
}

variable "role_all_write_privileges" {
  description = "Set all write privileges (True, False)"
  default     = false
}

variable "role_apply_to_orgs" {
  description = "(List of String) indicates which orgs this role applies to."
  default     = []
}

variable "role_privileges" {
  description = "(Set of String) Privileges to be assigned to the new role. It has the following structure - resource:read/write For example, metaports:read etc."
  default     = []
}

variable "role_suborgs_expression" {
  description = "(String) Allows grouping of entities according to their tags. Filtering by tag value is also supported, if provided. Supported operations: AND, OR, XOR, parenthesis."
  default     = ""
}

#-----------------------------------------------------------
# ProofPoint Meta user settings
#-----------------------------------------------------------
variable "enable_user_settings" {
  description = "Enable user settings usage"
  default     = false
}

variable "user_settings_name" {
  description = "Set user settings name"
  default     = ""
}

variable "user_settings_description" {
  description = "Set description"
  default     = ""
}

variable "user_settings_enabled" {
  description = "Set user settings (True, False)"
  default     = false
}

variable "user_settings_allowed_factors" {
  description = "(List of String) When users are configured to authenticate locally with MFA, you can choose which second authentication factors will be visible to this user group. The allowed values are: SMS, SOFTWARE_TOTP, VOICECALL, EMAIL. This applies ONLY to local Proofpoint accounts, not to accounts that authenticate via external IdPs (SSO)."
  default     = []
}

variable "user_settings_apply_on_org" {
  description = "(Boolean) Indicates whether this user setting applies to the entire org. Note: this attribute overrides apply_to_entities (True, False)"
  default     = false
}

variable "user_settings_apply_to_entities" {
  description = "(List of String) Entities (users, groups or network elements) that the user settings will be applied to."
  default     = []
}

variable "user_settings_max_devices_per_user" {
  description = "(String) Integer wrapped as string. Provides the administrator the flexibility to restrict how many devices the user can own or authenticate from."
  default     = ""
}

variable "user_settings_mfa_required" {
  description = "(Boolean) Forces the user for second factor authentication when logging in to Proofpoint NaaS. Enabling this enforces the user to authenticate also by a second factor, as specified by allowed_factors parameter."
  default     = false
}

variable "user_settings_password_expiration" {
  description = "(Number) Allows the administrator to set how often (in days) the end user should set a new login password."
  default     = 365
}

variable "user_settings_prohibited_os" {
  description = "(List of String) Allows the administrator to select operating systems which are prohibited from onboarding. ENUM: Android, macOS, iOS, Linux, Windows, ChromeOS"
  default     = []
}

variable "user_settings_proxy_pops" {
  description = "(String) Type of proxy_pops the user"
  default     = ""
}

variable "user_settings_sso_mandatory" {
  description = "(Boolean) Force the user into SSO authentication, via the configured IdP. If this option is enabled and the user attempts to login without SSO, the following message is displayed: Login without SSO is not allowed by system administrator."
  default     = false
}