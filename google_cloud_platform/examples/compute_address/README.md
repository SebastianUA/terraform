# Work with COMPUTE_ADDRESS via terraform

A terraform module for making COMPUTE_ADDRESS.


## Usage
----------------------
Import the module and retrieve with ```terraform get``` or ```terraform get --update```. Adding a module resource to your template, e.g. `main.tf`:

```
#
# MAINTAINER Vitaliy Natarov "vitaliy.natarov@yahoo.com"
#
terraform {
  required_version = "~> 0.13"
}

provider "google" {
  credentials = file("/Users/captain/.config/gcloud/creds/terraform_creds.json")
  project     = "terraform-2018"
  region      = "us-east1"
}

module "compute_address" {
  source = "../../modules/compute_address"
  name   = "TEST"

  enable_compute_address        = true
  enable_compute_global_address = true
}

```

## Module Input Variables
----------------------
- `name` - A unique name for the resource, required by GCE. Changing this forces a new resource to be created. (`default = TEST`)
- `environment` - Environment for service (`default = STAGE`)
- `project` - The project in which the resource belongs. If it is not provided, the provider project is used. (`default = ""`)
- `description` - (Optional) An optional description of this resource. (`default = ""`)
- `enable_compute_address` - Enable compute address usage (`default = true`)
- `address_type` - (Optional) The type of address to reserve, either INTERNAL or EXTERNAL. If unspecified, defaults to EXTERNAL. (`default = EXTERNAL`)
- `network_tier` - (Optional) The networking tier used for configuring this address. This field can take the following values: PREMIUM or STANDARD. If this field is not specified, it is assumed to be PREMIUM. (`default = PREMIUM`)
- `subnetwork` - (Optional) The URL of the subnetwork in which to reserve the address. If an IP address is specified, it must be within the subnetwork's IP range. This field can only be used with INTERNAL type with GCE_ENDPOINT/DNS_RESOLVER purposes. (`default = ""`)
- `region` - (Optional) The Region in which the created address should reside. If it is not provided, the provider region is used. (`default = ""`)
- `timeouts_create` - Time to create redis node. Default is 6 minutes. Valid units of time are s, m, h. (`default = 6m`)
- `timeouts_delete` - Time to delete redis node. Default is 4 minutes. Valid units of time are s, m, h. (`default = 4m`)
- `enable_compute_global_address` - Enable compute global address usage (`default = false`)
- `ip_version` - (Optional) The IP Version that will be used by this address. Valid options are IPV4 or IPV6. The default value is IPV4. (`default = IPV4`)

## Module Output Variables
----------------------
- `google_compute_address_name` - Name of google_compute_address
- `google_compute_address_self_link` - The URI of the created resource.
- `google_compute_address_address` - The IP of the created resource.
- `google_compute_address_users` - The URLs of the resources that are using this address.
- `google_compute_global_address_name` - Name of google_compute_global_address
- `google_compute_global_address_self_link` - The URI of the created resource.
- `google_compute_global_address_address` - The IP of the created resource.


## Authors

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA). An email: [vitaliy.natarov@yahoo.com](vitaliy.natarov@yahoo.com).

## License

Apache 2 Licensed. See [LICENSE](https://github.com/SebastianUA/terraform/blob/master/LICENSE) for full details.
