#---------------------------------------------------
# AWS shield protection
#---------------------------------------------------
output "shield_protection_id" {
    description = "The unique identifier (ID) for the Protection object that is created."
    value       = element(concat(aws_shield_protection.shield_protection.*.id, [""]), 0)
}