# Work with ADMINISTRATION via terraform

A terraform module for making ADMINISTRATION.


## Usage
----------------------
Import the module and retrieve with ```terraform get``` or ```terraform get --update```. Adding a module resource to your template, e.g. `main.tf`:

```
#
# MAINTAINER Vitaliy Natarov "vitaliy.natarov@yahoo.com"
#
terraform {
  required_version = "~> 1.0"

  required_providers {
    pfptmeta = {
      source  = "nsofnetworks/pfptmeta"
      version = "0.1.23"
    }
  }
}

provider "pfptmeta" {
  # Configuration options
}

```

## Module Input Variables
----------------------
- `name` - Name to be used on all resources as prefix (`default = TEST`)
- `environment` - Environment for service (`default = STAGE`)
- `enable_certificate` - Enable certificate usage (`default = False`)
- `certificate_name` - Set cert name (`default = ""`)
- `certificate_sans` - List of certificate SANs (`default = []`)
- `certificate_description` - Set certificate description (`default = ""`)
- `enable_log_streaming_access_bridge` - Enable log streaming access bridge usage (`default = False`)
- `log_streaming_access_bridge_name` - Set log streaming access bridge name (`default = ""`)
- `log_streaming_access_bridge_export_logs` - (List of String) Enum: api traffic security metaproxy webfilter (`default = []`)
- `log_streaming_access_bridge_description` - Set description (`default = ""`)
- `log_streaming_access_bridge_enabled` - Set log streaming access bridge enabled (`default = True`)
- `log_streaming_access_bridge_notification_channels` - (List of String) Notification channel IDs to which an alert will be sent if the log streaming service becomes unavailable or the endpoint is unreachable. (`default = []`)
- `log_streaming_access_bridge_proofpoint_casb_config` - (Block List, Max: 1) Configuration for log streaming to Proofpoint CASB for shadow IT processing. (`default = {}`)
- `log_streaming_access_bridge_qradar_http_config` - (Block List, Max: 1) Configuration for log streaming to IBM QRadar platform. (`default = {}`)
- `log_streaming_access_bridge_s3_config` - (Block List, Max: 1) Configuration for log streaming to an Amazon S3 bucket. (`default = {}`)
- `log_streaming_access_bridge_splunk_http_config` - (Block List, Max: 1) Configuration for log streaming to Self-Hosted / cloud Splunk. see here for instructions on how to enable HTTP Event Collector on Self-Hosted Instance, and here for instructions on how to enable HTTP Event Collector on Cloud Instance. (`default = {}`)
- `log_streaming_access_bridge_syslog_config` - (Block List, Max: 1) Configuration for log streaming in Syslog Common Event Format (CEF). (`default = {}`)
- `enable_role` - Enable role usage (`default = False`)
- `role_name` - Set role name (`default = ""`)
- `role_description` - Set description (`default = ""`)
- `role_all_read_privileges` - Set role all read privileges (True, False) (`default = False`)
- `role_all_suborgs` - Set all suborgs (True, False) (`default = False`)
- `role_all_write_privileges` - Set all write privileges (True, False) (`default = False`)
- `role_apply_to_orgs` - (List of String) indicates which orgs this role applies to. (`default = []`)
- `role_privileges` - (Set of String) Privileges to be assigned to the new role. It has the following structure - resource:read/write For example, metaports:read etc. (`default = []`)
- `role_suborgs_expression` - (String) Allows grouping of entities according to their tags. Filtering by tag value is also supported, if provided. Supported operations: AND, OR, XOR, parenthesis. (`default = ""`)
- `enable_user_settings` - Enable user settings usage (`default = False`)
- `user_settings_name` - Set user settings name (`default = ""`)
- `user_settings_description` - Set description (`default = ""`)
- `user_settings_enabled` - Set user settings (True, False) (`default = False`)
- `user_settings_allowed_factors` - (List of String) When users are configured to authenticate locally with MFA, you can choose which second authentication factors will be visible to this user group. The allowed values are: SMS, SOFTWARE_TOTP, VOICECALL, EMAIL. This applies ONLY to local Proofpoint accounts, not to accounts that authenticate via external IdPs (SSO). (`default = []`)
- `user_settings_apply_on_org` - (Boolean) Indicates whether this user setting applies to the entire org. Note: this attribute overrides apply_to_entities (True, False) (`default = False`)
- `user_settings_apply_to_entities` - (List of String) Entities (users, groups or network elements) that the user settings will be applied to. (`default = []`)
- `user_settings_max_devices_per_user` - (String) Integer wrapped as string. Provides the administrator the flexibility to restrict how many devices the user can own or authenticate from. (`default = ""`)
- `user_settings_mfa_required` - (Boolean) Forces the user for second factor authentication when logging in to Proofpoint NaaS. Enabling this enforces the user to authenticate also by a second factor, as specified by allowed_factors parameter. (`default = False`)
- `user_settings_password_expiration` - (Number) Allows the administrator to set how often (in days) the end user should set a new login password. (`default = 365`)
- `user_settings_prohibited_os` - (List of String) Allows the administrator to select operating systems which are prohibited from onboarding. ENUM: Android, macOS, iOS, Linux, Windows, ChromeOS (`default = []`)
- `user_settings_proxy_pops` - (String) Type of proxy_pops the user (`default = ""`)
- `user_settings_sso_mandatory` - (Boolean) Force the user into SSO authentication, via the configured IdP. If this option is enabled and the user attempts to login without SSO, the following message is displayed: Login without SSO is not allowed by system administrator. (`default = False`)

## Module Output Variables
----------------------
- `certificate_id` - The ID of this resource.
- `certificate_serial_number` - The serial number.
- `certificate_status` - Certificate state
- `certificate_valid_not_after` - The date valid_not_before
- `certificate_valid_not_before` - The date valid_not_before
- `log_streaming_access_bridge_id` - The ID of this resource.
- `log_streaming_access_bridge_status` - The status
- `role_id` - The ID of this resource.
- `user_settings_id` - The ID of this resource.


## Authors

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA). An email: [vitaliy.natarov@yahoo.com](vitaliy.natarov@yahoo.com).

## License

Apache 2 Licensed. See [LICENSE](https://github.com/SebastianUA/terraform/blob/master/LICENSE) for full details.
