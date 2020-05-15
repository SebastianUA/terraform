#---------------------------------------------------
# AWS macie s3 bucket association
#---------------------------------------------------
resource "aws_macie_s3_bucket_association" "macie_s3_bucket_association" {
    count                   = var.enable_macie_s3_bucket_association ? 1 : 0

    bucket_name             = var.macie_s3_bucket_association_bucket_name

    member_account_id       = var.macie_s3_bucket_association_member_account_id != "" && !var.enable_macie_member_account_association ? var.macie_s3_bucket_association_member_account_id : element(concat(aws_macie_member_account_association.macie_member_account_association.*.id, [""]), 0)
    prefix                  = var.macie_s3_bucket_association_prefix

    dynamic "classification_type" {
        iterator = classification_type
        for_each = var.macie_s3_bucket_association_classification_type
        content {
            continuous  = lookup(classification_type.value, "continuous", "FULL")
            one_time    = lookup(classification_type.value, "one_time", "NONE")
        }
    }

    lifecycle {
        create_before_destroy   = true
        ignore_changes          = []
    }

    depends_on              = [
        aws_macie_member_account_association.macie_member_account_association
    ]
}
