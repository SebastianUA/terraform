# Work with REPOSITORY via terraform

A terraform module for making REPOSITORY.


## Usage
----------------------
Import the module and retrieve with ```terraform get``` or ```terraform get --update```. Adding a module resource to your template, e.g. `main.tf`:

```
#
# MAINTAINER Vitaliy Natarov "vitaliy.natarov@yahoo.com"
#

terraform {
  required_version = ">= 0.13.0"

  required_providers {
    argocd = {
      source  = "oboukili/argocd"
      version = "0.4.7"
    }
  }
}

provider "argocd" {
  server_addr = "argocd.local:443" # env ARGOCD_SERVER
  auth_token  = "1234..."          # env ARGOCD_AUTH_TOKEN
  # username  = "admin"            # env ARGOCD_AUTH_USERNAME
  # password  = "foo"              # env ARGOCD_AUTH_PASSWORD
  insecure = false # env ARGOCD_INSECURE
}

module "argocd_repository" {
  source = "../../modules/repository"

  enable_repository = true
  repository_repo   = "https://helm.nginx.com/stable"
  repository_name   = "nginx-stable"
  repository_type   = "helm"
}

```

## Module Input Variables
----------------------
- `name` - The name for resources (`default = test`)
- `environment` - The environment for resources (`default = dev`)
- `enable_repository` - Enable argocd repository usage (`default = False`)
- `repository_repo` - (Required), string, URL of the repository. (`default = null`)
- `repository_name` - (Optional), string, only for Helm repositories. (`default = ""`)
- `repository_type` - (Optional), string, type of the repo, may be 'git' or 'helm'. Defaults to git. (`default = null`)
- `repository_insecure` - (Optional), boolean, whether to verify the repository TLS certificate. (`default = null`)
- `repository_enable_lfs` - (Optional), boolean, whether git-lfs support should be enabled for this repository. (`default = null`)
- `repository_username` - (Optional), string, username to authenticate against the repository server. (`default = null`)
- `repository_password` - (Optional), string, password to authenticate against the repository server. (`default = null`)
- `repository_ssh_private_key` - (Optional), string, SSH private key data to authenticate against the repository server. Only for Git repositories. (`default = null`)
- `repository_tls_client_cert_data` - (Optional), TLS client cert data to authenticate against the repository server. (`default = null`)
- `repository_tls_client_cert_key` - (Optional), TLS client cert key to authenticate against the repository server. (`default = null`)
- `enable_repository_credentials` - Enable argocd repository credentials usage (`default = False`)
- `repository_credentials_url` - (Required), string, URL that these credentials matches to. (`default = null`)
- `repository_credentials_username` - (Optional), string, username to authenticate against the repository server. (`default = null`)
- `repository_credentials_password` - (Optional), string, password to authenticate against the repository server. (`default = null`)
- `repository_credentials_ssh_private_key` - Optional), string, SSH private key data to authenticate against the repository server. Only for Git repositories. (`default = null`)
- `repository_credentials_tls_client_cert_data` - (Optional), TLS client cert data to authenticate against the repository server. (`default = null`)
- `repository_credentials_tls_client_cert_key` - (Optional), TLS client cert key to authenticate against the repository server. (`default = null`)

## Module Output Variables
----------------------
- `argocd_repository_id` - The ID of argocd repository
- `argocd_repository_connection_state_status` - string, repository connection state status.
- `argocd_repository_inherited_creds` - boolean, whether credentials wre inherited fron a credential set.
- `argocd_repository_credentials_id` - The ID of argocd repository credentials


## Authors

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA). An email: [vitaliy.natarov@yahoo.com](vitaliy.natarov@yahoo.com).

## License

Apache 2 Licensed. See [LICENSE](https://github.com/SebastianUA/terraform/blob/master/LICENSE) for full details.
