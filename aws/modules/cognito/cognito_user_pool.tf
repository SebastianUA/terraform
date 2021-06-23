#---------------------------------------------------
# AWS cognito user pool
#---------------------------------------------------
resource "aws_cognito_user_pool" "cognito_user_pool" {
  count = var.enable_cognito_user_pool ? 1 : 0

  name = var.cognito_user_pool_name != "" ? var.cognito_user_pool_name : "${lower(var.name)}-cognito-user-pool-${lower(var.environment)}"

  alias_attributes           = var.cognito_user_pool_alias_attributes
  auto_verified_attributes   = var.cognito_user_pool_auto_verified_attributes
  email_verification_message = var.cognito_user_pool_email_verification_message
  email_verification_subject = var.cognito_user_pool_email_verification_subject
  mfa_configuration          = upper(var.cognito_user_pool_mfa_configuration)
  sms_authentication_message = var.cognito_user_pool_sms_authentication_message
  sms_verification_message   = var.cognito_user_pool_sms_verification_message
  username_attributes        = var.cognito_user_pool_username_attributes

  dynamic "account_recovery_setting" {
    iterator = account_recovery_setting
    for_each = var.cognito_user_pool_account_recovery_setting

    content {
      dynamic "recovery_mechanism" {
        iterator = recovery_mechanism
        for_each = length(keys(lookup(account_recovery_setting.value, "recovery_mechanism", {}))) > 0 ? [lookup(account_recovery_setting.value, "recovery_mechanism", {})] : []

        content {
          name     = lookup(recovery_mechanism.value, "name", null)
          priority = lookup(recovery_mechanism.value, "priority", null)
        }
      }
    }
  }

  dynamic "admin_create_user_config" {
    iterator = admin_create_user_config
    for_each = var.cognito_user_pool_admin_create_user_config

    content {
      allow_admin_create_user_only = lookup(admin_create_user_config.value, "allow_admin_create_user_only", null)

      dynamic "invite_message_template" {
        iterator = invite_message_template
        for_each = length(keys(lookup(admin_create_user_config.value, "invite_message_template", {}))) > 0 ? [lookup(admin_create_user_config.value, "invite_message_template", {})] : []

        content {
          email_message = lookup(invite_message_template.value, "email_message", null)
          email_subject = lookup(invite_message_template.value, "email_subject", null)
          sms_message   = lookup(invite_message_template.value, "sms_message", null)
        }
      }
    }
  }

  dynamic "device_configuration" {
    iterator = device_configuration
    for_each = var.cognito_user_pool_device_configuration

    content {
      challenge_required_on_new_device      = lookup(device_configuration.value, "challenge_required_on_new_device", null)
      device_only_remembered_on_user_prompt = lookup(device_configuration.value, "device_only_remembered_on_user_prompt", null)
    }
  }

  dynamic "email_configuration" {
    iterator = email_configuration
    for_each = var.cognito_user_pool_email_configuration

    content {
      configuration_set      = lookup(email_configuration.value, "configuration_set", null)
      email_sending_account  = lookup(email_configuration.value, "email_sending_account", null)
      from_email_address     = lookup(email_configuration.value, "from_email_address", null)
      reply_to_email_address = lookup(email_configuration.value, "reply_to_email_address", null)
      source_arn             = lookup(email_configuration.value, "source_arn", null)
    }
  }

  dynamic "lambda_config" {
    iterator = lambda_config
    for_each = var.cognito_user_pool_lambda_config

    content {
      create_auth_challenge          = lookup(lambda_config.value, "create_auth_challenge", null)
      custom_message                 = lookup(lambda_config.value, "custom_message", null)
      define_auth_challenge          = lookup(lambda_config.value, "define_auth_challenge", null)
      post_authentication            = lookup(lambda_config.value, "post_authentication", null)
      post_confirmation              = lookup(lambda_config.value, "post_confirmation", null)
      pre_authentication             = lookup(lambda_config.value, "pre_authentication", null)
      pre_sign_up                    = lookup(lambda_config.value, "pre_sign_up", null)
      pre_token_generation           = lookup(lambda_config.value, "pre_token_generation", null)
      user_migration                 = lookup(lambda_config.value, "user_migration", null)
      verify_auth_challenge_response = lookup(lambda_config.value, "verify_auth_challenge_response", null)
      kms_key_id                     = lookup(lambda_config.value, "kms_key_id", null)

      dynamic "custom_email_sender" {
        iterator = custom_email_sender
        for_each = length(keys(lookup(lambda_config.value, "custom_email_sender", {}))) > 0 ? [lookup(lambda_config.value, "custom_email_sender", {})] : []

        content {
          lambda_arn     = lookup(custom_email_sender.value, "lambda_arn", null)
          lambda_version = lookup(custom_email_sender.value, "lambda_version", null)
        }
      }

      dynamic "custom_sms_sender" {
        iterator = custom_sms_sender
        for_each = length(keys(lookup(lambda_config.value, "custom_sms_sender", {}))) > 0 ? [lookup(lambda_config.value, "custom_sms_sender", {})] : []

        content {
          lambda_arn     = lookup(custom_sms_sender.value, "lambda_arn", null)
          lambda_version = lookup(custom_sms_sender.value, "lambda_version", null)
        }
      }
    }
  }

  dynamic "password_policy" {
    iterator = password_policy
    for_each = var.cognito_user_pool_password_policy

    content {
      minimum_length                   = lookup(password_policy.value, "minimum_length", null)
      require_lowercase                = lookup(password_policy.value, "require_lowercase", null)
      require_numbers                  = lookup(password_policy.value, "require_numbers", null)
      require_symbols                  = lookup(password_policy.value, "require_symbols", null)
      require_uppercase                = lookup(password_policy.value, "require_uppercase", null)
      temporary_password_validity_days = lookup(password_policy.value, "temporary_password_validity_days", null)
    }
  }

  dynamic "schema" {
    iterator = schema
    for_each = var.cognito_user_pool_schema

    content {
      name                = lookup(schema.value, "name", null)
      attribute_data_type = lookup(schema.value, "attribute_data_type", null)

      developer_only_attribute = lookup(schema.value, "developer_only_attribute", null)
      mutable                  = lookup(schema.value, "mutable", null)
      required                 = lookup(schema.value, "required", null)

      dynamic "number_attribute_constraints" {
        iterator = number_attribute_constraints
        for_each = length(keys(lookup(schema.value, "number_attribute_constraints", {}))) > 0 ? [lookup(schema.value, "number_attribute_constraints", {})] : []

        content {
          max_value = lookup(number_attribute_constraints.value, "max_value", null)
          min_value = lookup(number_attribute_constraints.value, "min_value", null)
        }
      }

      dynamic "string_attribute_constraints" {
        iterator = string_attribute_constraints
        for_each = length(keys(lookup(schema.value, "string_attribute_constraints", {}))) > 0 ? [lookup(schema.value, "string_attribute_constraints", {})] : []

        content {
          min_length = lookup(string_attribute_constraints.value, "min_length", null)
          max_length = lookup(string_attribute_constraints.value, "max_length", null)
        }
      }
    }
  }

  dynamic "sms_configuration" {
    iterator = sms_configuration
    for_each = length(keys(var.cognito_user_pool_sms_configuration)) > 0 ? [var.cognito_user_pool_sms_configuration] : []

    content {
      external_id    = lookup(sms_configuration.value, "external_id", null)
      sns_caller_arn = lookup(sms_configuration.value, "sns_caller_arn", null)
    }
  }

  dynamic "software_token_mfa_configuration" {
    iterator = software_token_mfa_configuration
    for_each = length(keys(var.cognito_user_pool_software_token_mfa_configuration)) > 0 ? [var.cognito_user_pool_software_token_mfa_configuration] : []

    content {
      enabled = lookup(software_token_mfa_configuration.value, "enabled", null)
    }
  }

  dynamic "user_pool_add_ons" {
    iterator = user_pool_add_ons
    for_each = length(keys(var.cognito_user_pool_user_pool_add_ons)) > 0 ? [var.cognito_user_pool_user_pool_add_ons] : []

    content {
      advanced_security_mode = lookup(user_pool_add_ons.value, "advanced_security_mode", null)
    }
  }

  dynamic "username_configuration" {
    iterator = username_configuration
    for_each = length(keys(var.cognito_user_pool_username_configuration)) > 0 ? [var.cognito_user_pool_username_configuration] : []

    content {
      case_sensitive = lookup(username_configuration.value, "case_sensitive", null)
    }
  }

  dynamic "verification_message_template" {
    iterator = verification_message_template
    for_each = var.cognito_user_pool_verification_message_template

    content {
      default_email_option  = lookup(verification_message_template.value, "default_email_option", null)
      email_message         = lookup(verification_message_template.value, "email_message", null)
      email_message_by_link = lookup(verification_message_template.value, "email_message_by_link", null)
      email_subject         = lookup(verification_message_template.value, "email_subject", null)
      email_subject_by_link = lookup(verification_message_template.value, "email_subject_by_link", null)
      sms_message           = lookup(verification_message_template.value, "sms_message", null)
    }
  }

  tags = merge(
    {
      Name = var.cognito_user_pool_name != "" ? var.cognito_user_pool_name : "${lower(var.name)}-cognito-user-pool-${lower(var.environment)}"
    },
    var.tags
  )

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}