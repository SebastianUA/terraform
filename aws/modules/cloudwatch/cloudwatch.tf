#---------------------------------------------------
# Create AWS CloudWatch metric alarm
#---------------------------------------------------
resource "aws_cloudwatch_metric_alarm" "cw_metric_alarm" {
    count               = "${var.alarm_name != "" ? 1 : 0}"

    alarm_name          = "${var.alarm_name}"
    comparison_operator = "${var.comparison_operator}"
    evaluation_periods  = "${var.evaluation_periods}"
    metric_name         = "${var.metric_name}"
    namespace           = "${var.namespace}"
    period              = "${var.period}"
    threshold           = "${var.threshold}"

    datapoints_to_alarm = "${var.datapoints_to_alarm}"
    actions_enabled     = "${var.actions_enabled}"
    dimensions          = "${var.dimensions}"

    alarm_description = "${var.alarm_description}"
    alarm_actions     = ["${var.alarm_actions}"]

    insufficient_data_actions   = "${var.insufficient_data_actions}"
    ok_actions                  = "${var.ok_actions}"
    
    #extended_statistic                      = "${var.extended_statistic}"
    #evaluate_low_sample_count_percentiles   = "${var.evaluate_low_sample_count_percentiles}"
    statistic                               = "${var.statistic}"
    treat_missing_data                      = "${var.treat_missing_data}"
}
#---------------------------------------------------
# Create AWS CloudWatch event permission
#---------------------------------------------------
resource "aws_cloudwatch_event_permission" "cw_event_permission" {
    count       = "${var.principal_for_event_permission != "" ? 1 : 0}"
                                                        
    principal    = "${var.principal_for_event_permission}"
    statement_id = "${var.statement_id_for_event_permission}"
    action      = "${var.action_for_event_permission}"
}
#---------------------------------------------------
# Create AWS CloudWatch event rule
#---------------------------------------------------
resource "aws_cloudwatch_event_rule" "cw_event_rule" {
    count       = "${var.arn_for_cloudwatch_event_target != "" ? 1 : 0}"
    name        = "capture-aws-sign-in"
    description = "Capture each AWS Console Sign In"

    event_pattern = <<PATTERN
        {
            "detail-type": [
                "AWS Console Sign In via CloudTrail"
            ]
        }
    PATTERN
    is_enabled  = "${var.is_enabled_for_event_rule}"
}

resource "aws_cloudwatch_event_target" "cloudwatch_event_target" {
    count   = "${var.arn_for_cloudwatch_event_target != "" ? 1 : 0}"
    
    rule      = "${aws_cloudwatch_event_rule.cw_event_rule.name}"
    target_id = "${var.target_id_for_cloudwatch_event_target}"
    arn       = "${var.arn_for_cloudwatch_event_target}"
}
#---------------------------------------------------
# Create AWS CloudWatch Create AWS dashboard
#---------------------------------------------------
resource "aws_cloudwatch_dashboard" "cloudwatch_dashboard" {
    count           = "${var.cloudwatch_dashboard_name !="" ? 1 : 0}"   

    dashboard_name  = "${var.cloudwatch_dashboard_name}"
    dashboard_body  = <<EOF
 {
   "widgets": [
       {
          "type":"metric",
          "x":0,
          "y":0,
          "width":12,
          "height":6,
          "properties":{
             "metrics":[
                [
                   "AWS/EC2",
                   "CPUUtilization",
                   "InstanceId",
                   "i-012345"
                ]
             ],
             "period":300,
             "stat":"Average",
             "region":"us-east-1",
             "title":"EC2 Instance CPU"
          }
       },
       {
          "type":"text",
          "x":0,
          "y":7,
          "width":3,
          "height":3,
          "properties":{
             "markdown":"Hello world"
          }
       }
   ]
 }
 EOF
}
#---------------------------------------------------
# Create AWS CloudWatch LOG group
#---------------------------------------------------
resource "aws_cloudwatch_log_group" "cw_log_group" {
    count               = "${var.name_for_cloudwatch_log_group !="" ? 1 : 0}"
    
    name                = "${var.name_for_cloudwatch_log_group}"
    retention_in_days   = "${var.retention_in_days_for_cloudwatch_log_group}"
    kms_key_id          = "${var.kms_key_id_for_cloudwatch_log_group}"
                                

    tags {
        Name            = "${var.name}-cw-log-group-${var.environment}"
        Environment     = "${var.environment}"
        Orchestration   = "${var.orchestration}"
        Createdby       = "${var.createdby}"
    }
}
#---------------------------------------------------
# Create AWS CloudWatch LOG metric filter
#---------------------------------------------------
resource "aws_cloudwatch_log_metric_filter" "cloudwatch_log_metric_filter" {
    count          = "${var.name_for_cloudwatch_log_group !="" ? 1 : 0}"    
                        
    name           = "${var.name_for_cloudwatch_log_metric_filter}"
    pattern        = "${var.pattern_for_cloudwatch_log_metric_filter}"
    log_group_name = "${aws_cloudwatch_log_group.cw_log_group.name}"
    
    metric_transformation {
        name      = "${var.name_for_metric_transformation}"
        namespace = "${var.namespace_for_metric_transformation}"
        value     = "${var.value_for_metric_transformation}"
    }
}
#---------------------------------------------------
# Create AWS CloudWatch LOG stream
#---------------------------------------------------
resource "aws_cloudwatch_log_stream" "cloudwatch_log_stream" {
    count          = "${var.name_for_cloudwatch_log_stream !="" ? 1 : 0}"     

    name           = "${var.name_for_cloudwatch_log_stream}"
    log_group_name = "${aws_cloudwatch_log_group.cw_log_group.name}"
}
