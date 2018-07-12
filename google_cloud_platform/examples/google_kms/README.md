# Work with Google Cloud  Platform (google kms) via terraform

A terraform module for making google KMS.
 
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
module "google_kms" {
    source                              = "../../modules/google_kms"
    name                                = "TEST"

    enable_kms_key_ring                 = false
    
    enable_kms_crypto_key_iam_binding   = false
    members                             = []
    
    enable_kms_crypto_key               = false
    
    enable_kms_crypto_key_iam_member    = false
    
    enable_kms_key_ring_iam_policy      = false
}
```

Module Input Variables
----------------------
- `name` - "A unique name for the resource, required by GCE. Changing this forces a new resource to be created." (`    default     = "TEST"`)
- `location` - "The Google Cloud Platform location for the KeyRing. A full list of valid locations can be found by running gcloud kms locations list." (`  default     = "us-east1"    `)
- `environment` - "Environment for service" (`    default     = "STAGE"`)
- `orchestration` - "Type of orchestration" (`    default     = "Terraform"`)
- `project` - "The project in which the resource belongs. If it is not provided, the provider project is used." (`    default     = ""`)
- `enable_kms_key_ring` - "Enable KMS key ring. Default - false" (`    default     = "false"`)
- `enable_kms_crypto_key_iam_binding` - "Enable KMS crypto key iam binding. Default -false" (`    default     = "false"`)
- `crypto_key_id` - "The crypto key ID, in the form {project_id}/{location_name}/{key_ring_name}/{crypto_key_name} or {location_name}/{key_ring_name}/{crypto_key_name}. In the second form, the provider's project setting will be used as a fallback." (`    default     = ""`)
- `role` - "The role that should be applied. Only one google_kms_crypto_key_iam_binding can be used per role. Note that custom roles must be of the format [projects|organizations]/{parent-name}/roles/{role-name}." (`    default     = "roles/editor"`)
- `members` - "(Required) A list of users that the role should apply to." (`    default     = []`)
- `enable_kms_crypto_key` - "Enable KMS crypto key" (`    default     = ""`)
- `key_ring` - "(Required) The id of the Google Cloud Platform KeyRing to which the key shall belong." (`    default     = ""`)
- `rotation_period` - "(Optional) Every time this period passes, generate a new CryptoKeyVersion and set it as the primary. The first rotation will take place after the specified period. The rotation period has the format of a decimal number with up to 9 fractional digits, followed by the letter s (seconds). It must be greater than a day (ie, 83400)." (`    default     = "86400s"`)
- `enable_kms_crypto_key_iam_member` - "Enable KMS crypto key iam member. Default -false" (`    default     = "false"`)
- `kms_crypto_key_iam_member` - "(Required) The user that the role should apply to." (`    default     = ""`)
- `enable_kms_key_ring_iam_policy` - "Enable KMS key ring iam policy. Default - false" (`    default     = "false"`)
- `key_ring_id` - "(Required) The key ring ID, in the form {project_id}/{location_name}/{key_ring_name} or {location_name}/{key_ring_name}. In the second form, the provider's project setting will be used as a fallback." (`    default     = ""`)


Authors
=======

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA)
(vitaliy.natarov@yahoo.com).

License
=======

Apache 2 Licensed. See [LICENSE](https://github.com/SebastianUA/terraform/blob/master/LICENSE) for full details.
