#---------------------------------------------------
# Create route53 query log
#---------------------------------------------------
resource "aws_route53_query_log" "route53_query_log" {
    count                           = var.enable_route53_query_log ? 1 : 0

    cloudwatch_log_group_arn        = var.cloudwatch_log_group_arn
    zone_id                         = var.route53_query_log_zone_id != "" ? var.route53_query_log_zone_id : element(concat(aws_route53_zone.route53_zone.*.id, [""]), 0)

    lifecycle {
        create_before_destroy   = true
        ignore_changes          = []
    }

    depends_on                      = [
        aws_route53_zone.route53_zone
    ]
}
