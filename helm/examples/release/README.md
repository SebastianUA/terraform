# Work with RELEASE via terraform

A terraform module for making RELEASE.


## Usage
----------------------
Import the module and retrieve with ```terraform get``` or ```terraform get --update```. Adding a module resource to your template, e.g. `main.tf`:

```
#
# MAINTAINER Vitaliy Natarov "vitaliy.natarov@yahoo.com"
#
terraform {
  required_version = "~> 1.0"
}

module "helm_release" {
  source = "../../modules/release"

  enable_release     = true
  release_name       = "argocd-dev"
  release_chart      = "argo-cd"
  release_repository = "https://argoproj.github.io/argo-helm"
  release_version    = "v1.7.6"

  release_namespace        = "argocd-dev"
  release_create_namespace = true
  release_values           = []

  release_set = [
    #  {
    #    name  = "global.image.repository"
    #    value = "argoproj/argocd"
    #  },
    #  {
    #    name  = "global.image.repository"
    #    value = "v1.7.10"
    #  },
    {
      name  = "server.service.type"
      value = "LoadBalancer"
    }
  ]
  release_set_sensitive = []
  release_postrender    = []

  release_timeout       = 600
  release_force_update  = false
  release_recreate_pods = true
  release_lint          = false

}

```

## Module Input Variables
----------------------
- `name` - The name for helm release resources (`default = test`)
- `environment` - Environment for service (`default = STAGE`)
- `enable_release` - Enable helm release usage (`default = False`)
- `release_name` - Release name. (`default = ""`)
- `release_chart` - (Required) Chart name to be installed. The chart name can be local path, a URL to a chart, or the name of the chart if repository is specified. It is also possible to use the <repository>/<chart> format here if you are running Terraform on a system that the repository has been added to with helm repo add but this is not recommended. (`default = ""`)
- `release_repository` - (Optional) Repository URL where to locate the requested chart. (`default = null`)
- `release_version` - (Optional) Specify the exact chart version to install. If this is not specified, the latest version is installed. (`default = null`)
- `release_namespace` - (Optional) The namespace to install the release into. Defaults to default. (`default = default`)
- `release_create_namespace` - (Optional) Create the namespace if it does not yet exist. Defaults to false. (`default = False`)
- `release_values` - (Optional) List of values in raw yaml to pass to helm. Values will be merged, in order, as Helm does with multiple -f options. (`default = null`)
- `release_repository_key_file` - (Optional) The repositories cert key file (`default = null`)
- `release_repository_cert_file` - (Optional) The repositories cert file (`default = null`)
- `release_repository_ca_file` - (Optional) The Repositories CA File. (`default = null`)
- `release_repository_username` - (Optional) Username for HTTP basic authentication against the repository. (`default = null`)
- `release_repository_password` - (Optional) Password for HTTP basic authentication against the repository. (`default = null`)
- `release_devel` - (Optional) Use chart development versions, too. Equivalent to version '>0.0.0-0'. If version is set, this is ignored. (`default = null`)
- `release_verify` - (Optional) Verify the package before installing it. Helm uses a provenance file to verify the integrity of the chart; this must be hosted alongside the chart. For more information see the Helm Documentation. Defaults to false. (`default = False`)
- `release_keyring` - (Optional) Location of public keys used for verification. Used only if verify is true. Defaults to /.gnupg/pubring.gpg in the location set by home (`default = /.gnupg/pubring.gpg`)
- `release_timeout` - (Optional) Time in seconds to wait for any individual kubernetes operation (like Jobs for hooks). Defaults to 300 seconds. (`default = 300`)
- `release_disable_webhooks` - (Optional) Prevent hooks from running. Defauts to false (`default = False`)
- `release_reuse_values` - (Optional) When upgrading, reuse the last release's values and merge in any overrides. If 'reset_values' is specified, this is ignored. Defaults to false. (`default = False`)
- `release_reset_values` - (Optional) When upgrading, reset the values to the ones built into the chart. Defaults to false. (`default = False`)
- `release_force_update` - (Optional) Force resource update through delete/recreate if needed. Defaults to false (`default = False`)
- `release_recreate_pods` - (Optional) Perform pods restart during upgrade/rollback. Defaults to false. (`default = False`)
- `release_cleanup_on_fail` - (Optional) Allow deletion of new resources created in this upgrade when upgrade fails. Defaults to false. (`default = False`)
- `release_max_history` - (Optional) Maximum number of release versions stored per release. Defaults to 0 (no limit). (`default = 0`)
- `release_atomic` - (Optional) If set, installation process purges chart on fail. The wait flag will be set automatically if atomic is used. Defaults to false (`default = False`)
- `release_skip_crds` - (Optional) If set, no CRDs will be installed. By default, CRDs are installed if not already present. Defaults to false. (`default = False`)
- `release_render_subchart_notes` - (Optional) If set, render subchart notes along with the parent. Defaults to true. (`default = True`)
- `release_disable_openapi_validation` - (Optional) If set, the installation process will not validate rendered templates against the Kubernetes OpenAPI Schema. Defaults to false (`default = False`)
- `release_wait` - (Optional) Will wait until all resources are in a ready state before marking the release as successful. It will wait for as long as timeout. Defaults to true (`default = True`)
- `release_dependency_update` - (Optional) Runs helm dependency update before installing the chart. Defaults to false. (`default = False`)
- `release_replace` - (Optional) Re-use the given name, even if that name is already used. This is unsafe in production. Defaults to false (`default = False`)
- `release_description` - (Optional) Set release description attribute (visible in the history). (`default = null`)
- `release_lint` - (Optional) Run the helm chart linter during the plan. Defaults to false. (`default = False`)
- `release_set` - fdfdsf (`default = fsdds`)
- `release_set_sensitive` - (Optional) Value block with custom sensitive values to be merged with the values yaml that won't be exposed in the plan's diff. (`default = []`)
- `release_postrender` - (Optional) Configure a command to run after helm renders the manifest which can alter the manifest contents. (`default = []`)

## Module Output Variables
----------------------
- `release_id` - Id of Helm release
- `release_metadata` - Metadata of Helm release


## Authors

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA). An email: [vitaliy.natarov@yahoo.com](vitaliy.natarov@yahoo.com).

## License

Apache 2 Licensed. See [LICENSE](https://github.com/SebastianUA/terraform/blob/master/LICENSE) for full details.
