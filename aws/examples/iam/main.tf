#
# MAINTAINER Vitaliy Natarov "vitaliy.natarov@yahoo.com"
#
#terraform {
#  required_version = "> 0.9.0"
#}
#provider "aws" {
#    region  = "us-east-1"
#    # access_key = "${var.aws_access_key}"
#    # secret_key = "${var.aws_secret_key}"
#}

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
  enable_crossaccount_role = "true" 
  cross_acc_principal_arns = ["222222222222","arn:aws:iam::333333333333:user/MyUser"]
  cross_acc_policy_arns    = ["arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryPowerUser", "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"] 
}
