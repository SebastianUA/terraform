#---------------------------------------------------
# AWS cloudfront public key
#---------------------------------------------------
resource "aws_cloudfront_public_key" "cloudfront_public_key" {
    count                   = var.enable_cloudfront_public_key ? 1 : 0

    encoded_key             = var.cloudfront_public_key_encoded_key

    comment                 = var.cloudfront_public_key_comment
    name                    = var.cloudfront_public_key_name != null && var.cloudfront_public_key_name_prefix == null  ? var.cloudfront_public_key_name : null
    name_prefix             = var.cloudfront_public_key_name_prefix != null && var.cloudfront_public_key_name == null ? var.cloudfront_public_key_name_prefix : null

    lifecycle {
        create_before_destroy   = true
        ignore_changes          = []
    }

    depends_on              = []
}
