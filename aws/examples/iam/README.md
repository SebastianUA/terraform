# Work with AWS IAM via terraform
=======================

A terraform module for making IAM.

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
provider "aws" {
    region  = "us-east-1"
    profile = "default"
    # access_key = "${var.aws_access_key}"
    # secret_key = "${var.aws_secret_key}"
}
module "aim" {
    source                          = "../../modules/iam"
    name                            = "TEST-AIM"
    region                          = "us-east-1"
    environment                     = "PROD"

    aws_iam_role-principals         = [
        "ec2.amazonaws.com",
    ]
    aws_iam_policy-actions           = [
        "cloudwatch:GetMetricStatistics",
        "logs:DescribeLogStreams",
        "logs:GetLogEvents",
        "elasticache:Describe*",
        "rds:Describe*",
        "rds:ListTagsForResource",
        "ec2:DescribeAccountAttributes",
        "ec2:DescribeAvailabilityZones",
        "ec2:DescribeSecurityGroups",
        "ec2:DescribeVpcs",
  ]
  # Enabling cross account role 
  enable_crossaccount_role = "false" 
  cross_acc_principal_arns = ["222222222222222","arn:aws:iam::333333333333:user/test"]
  cross_acc_policy_arns    = ["arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryPowerUser", "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"] 
}
```

Module Input Variables
----------------------

- `name` - Name to be used on all resources as prefix (`default = TEST-AIM`).
- `region` - The region where to deploy this code (e.g. us-east-1). The default `default = us-east-1`.
- `environment` - Environment for service (`default = STAGE`). Just uses for a tags
- `aws_iam_role-principals` - List of allowed principals.
- `aws_iam_policy-resources` - List of allowed resources (`default = ["*"]`).
- `aws_iam_policy-actions` - List of allowed actions (`default = ["*"]`).
- `enable_crossaccount_role` - Enabling cross account role (`default = "false"`).
- `cross_acc_principal_arns` - `default = ["222222222222","arn:aws:iam::333333333333:user/MyUser"]`
- `cross_acc_policy_arns` -    `default = ["arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryPowerUser", "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"]`
 

Authors
=======

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA)
(vitaliy.natarov@yahoo.com).

License
=======

Apache 2 Licensed. See LICENSE for full details.
