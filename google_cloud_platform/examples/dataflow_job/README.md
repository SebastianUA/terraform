# Work with Google Cloud  Platform (dataflow job) via terraform

A terraform module for making google dataflow job.
 
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
module "dataflow_job" {
    source                              = "../../modules/dataflow_job"
    name                                = "TEST"

    template_gcs_path                   = "gs://terraform-2018/templates/template_file"
    temp_gcs_location                   = "gs://terraform-2018/tmp_dir"
}
```

Module Input Variables
----------------------
- `name` - "A unique name for the resource, required by GCE. Changing this forces a new resource to be created." (`    default     = "TEST"`)
- `environment` - "Environment for service" (`    default     = "STAGE"`)
- `project` - "(Optional) The project in which the resource belongs. If it is not provided, the provider project is used." (`    default     = "terraform-2018"`)
- `template_gcs_path` - "(Required) The GCS path to the Dataflow job template. Expect 'gs://<bucket>/<path>'. Ex: 'gs://my-bucket/templates/template_file'" (`    default     = ""`)
- `temp_gcs_location` - "(Required) A writeable location on GCS for the Dataflow job to dump its temporary data. Expect 'gs://<bucket>/<path>'. Ex: 'gs://my-bucket/tmp_dir'" (`    default     = ""`)
- `zone` - "(Optional) The zone in which the created job should run. If it is not provided, the provider zone is used." (`    default     = "us-east1"`)
- `max_workers` - "(Optional) The number of workers permitted to work on the job. More workers may improve processing speed at additional cost." (`    default     = "1"`)
- `on_delete` - "(Optional) One of 'drain' or 'cancel'. Specifies behavior of deletion during terraform destroy. See above note." (`    default     = "cancel"`)
- `parameters` - "(Optional) Key/Value pairs to be passed to the Dataflow job (as used in the template)." (`    default     = []`)


Authors
=======

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA)
(vitaliy.natarov@yahoo.com).

License
=======

Apache 2 Licensed. See [LICENSE](https://github.com/SebastianUA/terraform/blob/master/LICENSE) for full details.
