#
# MAINTAINER Vitaliy Natarov "vitaliy.natarov@yahoo.com"
#
terraform {
  required_version = "~> 0.14"

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
