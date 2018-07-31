# Work with Google Cloud  Platform (compute ssl certificate and policy) via terraform

A terraform module for making google compute ssl certificate and policy.
 
## Usage
--------

Import the module and retrieve with ```terraform get``` or ```terraform get --update```. Adding a module resource to your template, e.g. `main.tf`:

```
#
# MAINTAINER Vitaliy Natarov "vitaliy.natarov@yahoo.com"
#
terraform {
  required_version = "> 0.9.0"
}
provider "google" {
    credentials = "${file("/Users/captain/.config/gcloud/creds/terraform_creds.json")}"
    project     = "terraform-2018"
    region      = "us-east1"
}   

module "compute_ssl" {
    source                          = "../../modules/compute_ssl"
    name                            = "TEST"

    # Use MODERN
    enable_compute_ssl_policy       = true
    profile                         = "MODERN"
    min_tls_version                 = "TLS_1_2"

    # Use custom
    #enable_compute_ssl_policy       = true
    #profile                         = "CUSTOM"
    #min_tls_version                 = "TLS_1_0"
    #custom_features                 = ["TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384", "TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384"]
}

module "compute_ssl_certificate" {
    source                          = "../../modules/compute_ssl"

    # Use with name
    #name                            = "TEST"
    #enable_compute_ssl_certificate  = true
    #private_key                     = "/Users/captain/.ssh/gcloud_id_rsa"
    #certificate                     = "/Users/captain/.ssh/certificate"

    # Use prefix-name
    name                            = ""
    name_prefix                     = "cert-"
    enable_compute_ssl_certificate  = true
    private_key                     = "/Users/captain/.ssh/gcloud_id_rsa"
    certificate                     = "/Users/captain/.ssh/certificate"
}
```

Module Input Variables
----------------------
- `name` - "A unique name for the resource, required by GCE. Changing this forces a new resource to be created." (`    default     = "TEST"`)
- `environment` - "Environment for service" (`    default     = "STAGE"`)
- `project` - "The project in which the resource belongs. If it is not provided, the provider project is used." (`    default     = ""`)
- `description` - " (Optional) An optional description of this resource." (`    default     = ""`)
- `enable_compute_ssl_policy` - "Enable compute ssl policy usage" (`    default     = "false"`)
- `profile` - "(Optional) Profile specifies the set of SSL features that can be used by the load balancer when negotiating SSL with clients. This can be one of COMPATIBLE, MODERN, RESTRICTED, or CUSTOM. If using CUSTOM, the set of SSL features to enable must be specified in the customFeatures field. See the official documentation for information on what cipher suites each profile provides. If CUSTOM is used, the custom_features attribute must be set. Default is COMPATIBLE." (`    default     = "COMPATIBLE"`)
- `min_tls_version` - "(Optional) The minimum version of SSL protocol that can be used by the clients to establish a connection with the load balancer. This can be one of TLS_1_0, TLS_1_1, TLS_1_2. Default is TLS_1_0." (`    default     = "TLS_1_0"`)
- `custom_features` - "(Optional) Profile specifies the set of SSL features that can be used by the load balancer when negotiating SSL with clients. This can be one of COMPATIBLE, MODERN, RESTRICTED, or CUSTOM. If using CUSTOM, the set of SSL features to enable must be specified in the customFeatures field. See the official documentation for which ciphers are available to use. Note: this argument must be present when using the CUSTOM profile. This argument must not be present when using any other profile." (`    default     = []`)
- `timeouts_create` - "Time to create. Default is 4 minutes. Valid units of time are s, m, h." (`    default     = "4m"`)
- `timeouts_update` - "Time to update. Default is 4 minutes. Valid units of time are s, m, h." (`    default     = "4m"`)
- `timeouts_delete` - "Time to delete. Default is 4 minutes. Valid units of time are s, m, h." (`    default     = "4m"`)
- `enable_compute_ssl_certificate` - "Enable compute ssl certificate usage"  (`    default     = "false"`)
- `name_prefix` - "(Optional) Creates a unique name beginning with the specified prefix. Conflicts with name." (`    default     = ""`)
- `certificate` - "(Required) A local certificate file in PEM format. The chain may be at most 5 certs long, and must include at least one intermediate cert. Changing this forces a new resource to be created." (`    default     = ""`)
- `private_key` - "(Required) Write only private key in PEM format. Changing this forces a new resource to be created." (`    default     = ""`)


Authors
=======

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA)
(vitaliy.natarov@yahoo.com).

License
=======

Apache 2 Licensed. See [LICENSE](https://github.com/SebastianUA/terraform/blob/master/LICENSE) for full details.
