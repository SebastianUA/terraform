# Work with Google Cloud  Platform (compute disk) via terraform

A terraform module for making google compute disk.
 
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
module "compute_disk" {
    source                              = "../../modules/compute_disk"
    name                                = "TEST"

}
```

Module Input Variables
----------------------
- `name` - Name of the resource. Provided by the client when the resource is created. The name must be 1-63 characters long, and comply with RFC1035. Specifically, the name must be 1-63 characters long and match the regular expression [a-z]([-a-z0-9]*[a-z0-9])? which means the first character must be a lowercase letter, and all following characters must be a dash, lowercase letter, or digit, except the last character, which cannot be a dash (`default     = "TEST"`).
- `zone` - The zone that the machine should be created in (`default     = "us-east1-b" `).
- `environment` - Environment for service (`default     = "STAGE"`).
- `orchestration` - Type of orchestration (`default     = "Terraform"`).
- `description` - An optional description of this resource. Provide this property when you create the resource (`default     = ""`).
- `size` - Size of the persistent disk, specified in GB. You can specify this field when creating a persistent disk using the sourceImage or sourceSnapshot parameter, or specify it alone to create an empty persistent disk (`default     = "10"`).
- `type` - URL of the disk type resource describing which disk type to use to create the disk. Provide this when creating the disk.The GCE disk type. May be set to pd-standard or pd-ssd (`default     = "pd-ssd"`).
- `image` - The image from which to initialize this disk. This can be one of: the image's self_link, projects/{project}/global/images/{image}, projects/{project}/global/images/family/{family}, global/images/{image}, global/images/family/{family}, family/{family}, {project}/{family}, {project}/{image}, {family}, or {image}. If referred by family, the images names must include the family name (`default     = "centos-7"`).
- `disk_encryption_key_raw_key` - Specifies a 256-bit customer-supplied encryption key, encoded in RFC 4648 base64 to either encrypt or decrypt this resource. * sha256 - The RFC 4648 base64 encoded SHA-256 hash of the customer-supplied encryption key that protects this resource (`default     = ""`).
- `source_image_encryption_key_raw_key` - Specifies a 256-bit customer-supplied encryption key, encoded in RFC 4648 base64 to either encrypt or decrypt this resource. * sha256 - The RFC 4648 base64 encoded SHA-256 hash of the customer-supplied encryption key that protects this resource (`default     = ""`).
- `timeouts_create` - Set timeouts for create. Default is 5 minutes (default     = "5m").
- `timeouts_update` - Set timeouts for update. Default is 4 minutes (default     = "4m").
- `timeouts_delete` - Set timeouts for delete. Default is 4 minutes (default     = "4m").


Authors
=======

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA)
(vitaliy.natarov@yahoo.com).

License
=======

Apache 2 Licensed. See [LICENSE](https://github.com/SebastianUA/terraform/blob/master/LICENSE) for full details.
