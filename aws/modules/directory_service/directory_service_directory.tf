#---------------------------------------------------
# AWS directory service directory
#---------------------------------------------------
resource "aws_directory_service_directory" "directory_service_directory" {
  count = var.enable_directory_service_directory ? 1 : 0

  name     = var.directory_service_directory_name != "" ? lower(var.directory_service_directory_name) : "corp.example.com"
  password = var.directory_service_directory_password

  size        = var.directory_service_directory_size
  alias       = var.directory_service_directory_alias
  description = var.directory_service_directory_description
  short_name  = var.directory_service_directory_short_name
  enable_sso  = var.directory_service_directory_enable_sso
  type        = var.directory_service_directory_type
  edition     = var.directory_service_directory_edition


  dynamic "vpc_settings" {
    iterator = vpc_settings
    for_each = var.directory_service_directory_vpc_settings
    content {
      vpc_id     = lookup(vpc_settings.value, "vpc_id", null)
      subnet_ids = lookup(vpc_settings.value, "subnet_ids", null)
    }
  }

  dynamic "connect_settings" {
    iterator = connect_settings
    for_each = var.directory_service_directory_connect_settings
    content {
      customer_dns_ips  = lookup(connect_settings.value, "customer_dns_ips", null)
      customer_username = lookup(connect_settings.value, "customer_username", null)
      subnet_ids        = lookup(connect_settings.value, "subnet_ids", null)
      vpc_id            = lookup(connect_settings.value, "vpc_id", null)
    }
  }

  tags = merge(
    {
      Name = var.directory_service_directory_name != "" ? lower(var.directory_service_directory_name) : "corp.example.com"
    },
    var.tags
  )

  lifecycle {
    create_before_destroy = true
    ignore_changes        = [
      id,
      edition
    ]
  }

  depends_on = []
}