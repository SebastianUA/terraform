#---------------------------------------------------
# AWS cloudfront origin access identity
#---------------------------------------------------
resource "aws_cloudfront_origin_access_identity" "cloudfront_origin_access_identity" {
    count           = var.enable_cloudfront_origin_access_identity ? 1 : 0

    comment         = var.cloudfront_origin_access_identity

    lifecycle {
        create_before_destroy   = true
        ignore_changes          = []
    }

    depends_on      = []
}
