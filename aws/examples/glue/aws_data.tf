# Get the usera and account information
data "aws_caller_identity" "current" {
}

# Get the correct AWS partition values can be:
#     "aws"        - Public AWS partition 
#     "aws-cn"     - AWS China partition
#     "aws-us-gov" - US Government partition
data "aws_partition" "current" {
}