# Work with CONSUL_ACL via terraform

A terraform module for making CONSUL_ACL.


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
    consul = {
      source  = "hashicorp/consul"
      version = "~> 2.11.0"
    }
  }
}

provider "consul" {
  address    = "127.0.0.1:8500"
  scheme     = "http"
  datacenter = "dc1"

  ca_file        = null
  ca_pem         = null
  cert_file      = null
  cert_pem       = null
  key_file       = null
  key_pem        = null
  ca_path        = null
  http_auth      = null
  token          = null
  insecure_https = null
}

module "consul_acl_complex" {
  source = "../../modules/consul_acl"

  # Create Consul acl policy
  enable_acl_policy = true
  acl_policy_name   = "acl-policy"
  acl_policy_rules  = <<-RULE
    node_prefix "" {
      policy = "read"
    }
    node "" {
      policy = "read"
    }
    RULE

  acl_policy_description = "Some description for Consul ACL policy"
  acl_policy_datacenters = ["dc1"]

  # Create Consul acl role
  enable_acl_role      = true
  acl_role_name        = "acl-role"
  acl_role_description = "Some description for Consul ACL role"
  acl_role_service_identities = [
    {
      service_name = "foo"
    }
  ]

  # Create Consul acl auth method
  enable_acl_auth_method      = true
  acl_auth_method_name        = "acl-auth-method-kubernetes"
  acl_auth_method_type        = "kubernetes"
  acl_auth_method_description = "Some desctription for Consul ACL auth method (kubernetes)"
  acl_auth_method_config_json = jsonencode({
    Host              = "https://192.0.2.42:8443"
    CACert            = "-----BEGIN CERTIFICATE-----\n...-----END CERTIFICATE-----\n"
    ServiceAccountJWT = "eyJhbGciOiJSUzI1NiIsImtpZCI6IiJ9..."
  })

  # Create Consul acl binding rule
  enable_acl_binding_rule      = true
  acl_binding_rule_bind_type   = "service"
  acl_binding_rule_bind_name   = "minikube"
  acl_binding_rule_description = "Some desctription for Consul ACL binding rule (kubernetes)"
  acl_binding_rule_selector    = "serviceaccount.namespace==default"

  # Create Consul acl token
  enable_acl_token      = true
  acl_token_description = "Some desctription for Consul ACL token"
  acl_token_local       = true

  # Create Consul acl token policy attachment
  enable_acl_token_policy_attachment = true
}

```

## Module Input Variables
----------------------
- `name` - Set name for Consul namespace if doesnt set acl's name properly (`default = False`)
- `environment` - Set env for Consul acl if does not set name (`default = dev`)
- `enable_acl_policy` - Enable Consul ACL policy usage (`default = False`)
- `acl_policy_name` - The name of the policy. (`default = null`)
- `acl_policy_rules` - (Required) The rules of the policy. (`default = null`)
- `acl_policy_description` - (Optional) The description of the policy. (`default = null`)
- `acl_policy_datacenters` - (Optional) The datacenters of the policy. (`default = null`)
- `acl_policy_namespace` - (Optional, Enterprise Only) The namespace to create the policy within. (`default = null`)
- `enable_acl_role` - Enable acl role usage (`default = False`)
- `acl_role_name` - The name of the ACL role. (`default = ""`)
- `acl_role_description` - (Optional) A free form human readable description of the role. (`default = null`)
- `acl_role_policies` - (Optional) The list of policies that should be applied to the role. (`default = null`)
- `acl_role_namespace` - (Optional, Enterprise Only) The namespace to create the role within. (`default = null`)
- `acl_role_service_identities` - (Optional) The list of service identities that should be applied to the role. (`default = []`)
- `enable_acl_auth_method` - Enable Consul acl auth method usage (`default = False`)
- `acl_auth_method_name` - The name of the ACL auth method. (`default = ""`)
- `acl_auth_method_type` - (Required) The type of the ACL auth method (Ex: kubernetes, jwt). (`default = null`)
- `acl_auth_method_config_json` - (Required) The raw configuration for this ACL auth method. (`default = null`)
- `acl_auth_method_display_name` - (Optional) An optional name to use instead of the name attribute when displaying information about this auth method. (`default = null`)
- `acl_auth_method_description` - (Optional) A free form human readable description of the auth method. (`default = null`)
- `acl_auth_method_max_token_ttl` - (Optional) The maximum life of any token created by this auth method. (`default = null`)
- `acl_auth_method_token_locality` - Optional) The kind of token that this auth method produces. This can be either 'local' or 'global'. (`default = null`)
- `acl_auth_method_namespace` - (Optional, Enterprise Only) The namespace to create the policy within. (`default = null`)
- `acl_auth_method_namespace_rule` - (Optional, Enterprise Only) A set of rules that control which namespace tokens created via this auth method will be created within. (`default = []`)
- `enable_acl_binding_rule` - Enable Consul acl binding rule usage (`default = False`)
- `acl_binding_rule_auth_method` - The name of the ACL auth method this rule apply. (`default = ""`)
- `acl_binding_rule_bind_type` - (Required) Specifies the way the binding rule affects a token created at login. (`default = null`)
- `acl_binding_rule_bind_name` - (Required) The name to bind to a token at login-time. (`default = null`)
- `acl_binding_rule_description` - (Optional) A free form human readable description of the binding rule. (`default = null`)
- `acl_binding_rule_selector` - (Optional) The expression used to math this rule against valid identities returned from an auth method validation. (`default = null`)
- `acl_binding_rule_namespace` - (Optional, Enterprise Only) The namespace to create the binding rule within. (`default = null`)
- `enable_acl_token` - Enable Consul acltoken usage (`default = False`)
- `acl_token_accessor_id` - (Optional) The uuid of the token. If omitted, Consul will generate a random uuid. (`default = null`)
- `acl_token_description` - (Optional) The description of the token. (`default = null`)
- `acl_token_policies` - (Optional) The list of policies attached to the token. (`default = null`)
- `acl_token_roles` - (Optional) The list of roles attached to the token. (`default = null`)
- `acl_token_local` - (Optional) The flag to set the token local to the current datacenter. (`default = null`)
- `acl_token_namespace` - (Optional, Enterprise Only) The namespace to create the token within. (`default = null`)
- `enable_acl_token_policy_attachment` - Enable Consul acl token policy attachment usage (`default = False`)
- `acl_token_policy_attachment_token_id` - The id of the token. (`default = ""`)
- `acl_token_policy_attachment_policy` - The name of the policy attached to the token. (`default = ""`)

## Module Output Variables
----------------------
- `consul_acl_policy_id` - The ID of the policy.
- `consul_acl_policy_name` - The name of the policy.
- `consul_acl_policy_description` - The description of the policy.
- `consul_acl_policy_rules` - The rules of the policy.
- `consul_acl_policy_datacenters` - The datacenters of the policy.
- `consul_acl_role_id` - The ID of the role.
- `consul_acl_role_name` - The name of the ACL role.
- `consul_acl_role_description` - A free form human readable description of the role.
- `consul_acl_role_policies` - The list of policies that should be applied to the role.
- `consul_acl_role_service_identities` - The list of service identities that should be applied to the role.
- `consul_acl_auth_method_id` - The ID of the the auth method.
- `consul_acl_auth_method_name` - The name of the ACL auth method.
- `consul_acl_auth_method_type` - The type of the ACL auth method.
- `consul_acl_auth_method_display_name` - An optional name to use instead of the name attribute when displaying information about this auth method.
- `consul_acl_auth_method_max_token_ttl` - The maximum life of any token created by this auth method.
- `consul_acl_auth_method_token_locality` - The kind of token that this auth method produces. This can be either 'local' or 'global'.
- `consul_acl_auth_method_description` - A free form human readable description of the auth method.
- `consul_acl_auth_method_config_json` - The raw configuration for this ACL auth method.
- `consul_acl_auth_method_namespace` - (Enterprise Only) The namespace to create the policy within.
- `consul_acl_auth_method_namespace_rule` - (Enterprise Only) A set of rules that control which namespace tokens created via this auth method will be created within.
- `consul_acl_binding_rule_id` - The ID of the the binding rule.
- `consul_acl_binding_rule_auth_method` - The name of the ACL auth method this rule apply.
- `consul_acl_binding_rule_description` - A free form human readable description of the binding rule.
- `consul_acl_binding_rule_selector` - The expression used to math this rule against valid identities returned from an auth method validation.
- `consul_acl_binding_rule_bind_type` - Specifies the way the binding rule affects a token created at login.
- `consul_acl_binding_rule_bind_name` - The name to bind to a token at login-time.
- `consul_acl_token_id` - The token ID.
- `consul_acl_token_accessor_id` - The token accessor ID.
- `consul_acl_token_description` - The description of the token.
- `consul_acl_token_policies` - The list of policies attached to the token.
- `consul_acl_token_roles` - The list of roles attached to the token.
- `consul_acl_token_local` - The flag to set the token local to the current datacenter.
- `consul_acl_token_policy_attachment_id` - The attachment ID.
- `consul_acl_token_policy_attachment_token_id` - The id of the token.
- `consul_acl_token_policy_attachment_policy` - The name of the policy attached to the token.


## Authors

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA). An email: [vitaliy.natarov@yahoo.com](vitaliy.natarov@yahoo.com).

## License

Apache 2 Licensed. See [LICENSE](https://github.com/SebastianUA/terraform/blob/master/LICENSE) for full details.
