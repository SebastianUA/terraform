#
# MAINTAINER Vitaliy Natarov "vitaliy.natarov@yahoo.com"
#
terraform {
  required_version = "~> 0.14"

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
