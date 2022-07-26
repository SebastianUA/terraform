# Work with K8S_STORAGE_CLASS via terraform

A terraform module for making K8S_STORAGE_CLASS.


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
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 1.13.3"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "~> 1.3.2"
    }
  }
}

module "k8s_storage_class" {
  source = "../../modules/k8s_storage_class"

  enable_storage_class = true
  storage_class_name   = "k8s-sc"

  storage_class_annotations = {
    name = "example-annotation"
  }

  storage_class_labels = {
    mylabel = "label-value"
  }

  storage_class_storage_provisioner = "kubernetes.io/aws-ebs"
  storage_class_reclaim_policy      = "Delete"
  storage_class_parameters = {
    type      = "io1"
    iopsPerGB = "10"
    fsType    = "ext4"
  }

  storage_class_mount_options          = ["file_mode=0700", "dir_mode=0777", "mfsymlinks", "uid=1000", "gid=1000", "nobrl", "cache=none"]
  storage_class_allow_volume_expansion = true
  storage_class_volume_binding_mode    = null

}

```

## Module Input Variables
----------------------
- `name` - The name for helm release resources (`default = test`)
- `environment` - Environment for service (`default = STAGE`)
- `enable_storage_class` - Enable ns for kubernetes usage (`default = False`)
- `storage_class_name` - (Optional) Name of the namespace, must be unique. Cannot be updated. For more info see Kubernetes reference (`default = ""`)
- `storage_class_generate_name` - (Optional) Prefix, used by the server, to generate a unique name ONLY IF the name field has not been provided. This value will also be combined with a unique suffix. Read more about name idempotency. (`default = null`)
- `storage_class_annotations` - (Optional) An unstructured key value map stored with the namespace that may be used to store arbitrary metadata. (`default = {}`)
- `storage_class_labels` - (Optional) Map of string keys and values that can be used to organize and categorize (scope and select) namespaces. May match selectors of replication controllers and services. (`default = {}`)
- `storage_class_storage_provisioner` - (Required) Indicates the type of the provisioner (`default = []`)
- `storage_class_reclaim_policy` - (Optional) Indicates the reclaim policy to use. If no reclaimPolicy is specified when a StorageClass object is created, it will default to Delete. (`default = Delete`)
- `storage_class_parameters` - (Optional) The parameters for the provisioner that should create volumes of this storage class. Read more about available parameters. (`default = null`)
- `storage_class_mount_options` - (Optional) Persistent Volumes that are dynamically created by a storage class will have the mount options specified. (`default = null`)
- `storage_class_volume_binding_mode` - (Optional) Indicates when volume binding and dynamic provisioning should occur. (`default = null`)
- `storage_class_allow_volume_expansion` - (Optional) Indicates whether the storage class allow volume expand, default true. (`default = True`)

## Module Output Variables
----------------------
- `storage_class_id` - ID of Kubernetes storage_class


## Authors

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA). An email: [vitaliy.natarov@yahoo.com](vitaliy.natarov@yahoo.com).

## License

Apache 2 Licensed. See [LICENSE](https://github.com/SebastianUA/terraform/blob/master/LICENSE) for full details.
