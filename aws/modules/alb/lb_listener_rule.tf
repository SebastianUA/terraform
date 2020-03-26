#---------------------------------------------------
# AWS LB listener rule
#---------------------------------------------------

# Forward action
resource "aws_lb_listener_rule" "lb_listener_rule_forward" {
    count               = var.enable_lb_listener_rule && var.lb_listener_rule_forward ? 1 : 0

    listener_arn        = var.listener_arn
    priority            = var.priority

    action {
        type             = "forward"
        target_group_arn = var.target_group_arn
    }

    condition {
        field  = "host-header"
        values = var.condition_values
    }

    lifecycle {
        create_before_destroy   = true
        ignore_changes          = []
    }

    depends_on          = [
        aws_lb_listener.frontend_http,
        aws_lb_listener.frontend_https
    ]
}

# Redirect action
resource "aws_lb_listener_rule" "lb_listener_rule_redirect" {
    count               = var.enable_lb_listener_rule && var.enable_lb_listener_rule_redirect ? 1 : 0

    listener_arn        = var.listener_arn

    action {
        type = "redirect"

        redirect {
            host        = var.redirect_host
            port        = var.redirect_port
            protocol    = var.redirect_protocol
            status_code = var.redirect_status_code
            path        = var.redirect_path
            query       = var.redirect_query
        }
    }

    condition {
        field  = "host-header"
        values = var.condition_values
    }

    lifecycle {
        create_before_destroy   = true
        ignore_changes          = []
    }

    depends_on          = [
        aws_lb_listener.frontend_http,
        aws_lb_listener.frontend_https
    ]
}

# Fixed-response action
resource "aws_lb_listener_rule" "lb_listener_rule_fixed_response" {
    count               = var.enable_lb_listener_rule && var.lb_listener_rule_fixed_response ? 1 : 0

    listener_arn        = var.listener_arn

    action {
        type = "fixed-response"

        fixed_response {
            content_type = var.fixed_response_content_type
            message_body = var.fixed_response_message_body
            status_code  = var.fixed_response_status_code
        }
    }

    condition {
        field  = "path-pattern"
        values = var.condition_values
    }

    lifecycle {
        create_before_destroy   = true
        ignore_changes          = []
    }

    depends_on          = [
        aws_lb_listener.frontend_http,
        aws_lb_listener.frontend_https
    ]
}

# Authenticate-cognito Action
resource "aws_lb_listener_rule" "lb_listener_rule_cognito" {
    count               = var.enable_lb_listener_rule && var.enable_lb_listener_rule_cognito ? 1 : 0

    listener_arn        = var.listener_arn

    action {
        type = "authenticate-cognito"

        authenticate_cognito {
            authentication_request_extra_params = var.authenticate_cognito_authentication_request_extra_params
            on_unauthenticated_request          = var.authenticate_cognito_on_unauthenticated_request
            scope                               = var.authenticate_cognito_scope
            session_cookie_name                 = var.authenticate_cognito_session_cookie_name
            session_timeout                     = var.authenticate_cognito_session_timeout

            user_pool_arn                       = var.authenticate_cognito_user_pool_arn
            user_pool_client_id                 = var.authenticate_cognito_user_pool_client_id
            user_pool_domain                    = var.authenticate_cognito_user_pool_domain
        }
    }

    condition {
        field  = "path-pattern"
        values = var.condition_values
    }

    action {
        type             = "forward"
        target_group_arn = var.target_group_arn
    }

    lifecycle {
        create_before_destroy   = true
        ignore_changes          = []
    }

    depends_on          = [
        aws_lb_listener.frontend_http,
        aws_lb_listener.frontend_https
    ]
}

# Authenticate-oidc Action
resource "aws_lb_listener_rule" "lb_listener_rule_oidc" {
    count               = var.enable_lb_listener_rule && var.enable_lb_listener_rule_oidc ? 1 : 0

    listener_arn        = var.listener_arn

    action {
        type = "authenticate-oidc"

        authenticate_oidc {
            authentication_request_extra_params = var.authenticate_oidc_authentication_request_extra_params
            authorization_endpoint              = var.authenticate_oidc_authorization_endpoint
            client_id                           = var.authenticate_oidc_client_id
            client_secret                       = var.authenticate_oidc_client_secret
            issuer                              = var.authenticate_oidc_issuer
            token_endpoint                      = var.authenticate_oidc_token_endpoint
            user_info_endpoint                  = var.authenticate_oidc_user_info_endpoint

            on_unauthenticated_request          = var.authenticate_oidc_on_unauthenticated_request
            scope                               = var.authenticate_oidc_scope
            session_cookie_name                 = var.authenticate_oidc_session_cookie_name
            session_timeout                     = var.authenticate_oidc_session_timeout

        }
    }

    action {
        type             = "forward"
        target_group_arn = var.target_group_arn
    }

    condition {
        field  = "path-pattern"
        values = var.condition_values
    }

    lifecycle {
        create_before_destroy   = true
        ignore_changes          = []
    }

    depends_on          = [
        aws_lb_listener.frontend_http,
        aws_lb_listener.frontend_https
    ]
}
