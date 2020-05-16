#---------------------------------------------------
# Add a record to the domain
#---------------------------------------------------
variable "enable_record" {
    description = "Enable cloudflare record usage"
    default     = false
}

variable "record_name" {
    description = "The name of the record"
    default     = "cloudflare_name"
}

variable "record_zone_id" {
    description = "(Required) The DNS zone ID to add the record to"
    default     = ""
}

variable "record_type" {
    description = "The type of the record"
    default     = "A"
}

variable "record_value" {
    description = "The value of the record. Ex: 192.168.13.113"
    default     = null
}

variable "record_data" {
  description   = "description"
  default       = null
#   {
#     service  = "_sip"
#     proto    = "_tls"
#     name     = "terraform-srv"
#     priority = 0
#     weight   = 0
#     port     = 443
#     target   = "linux-notes.org"
#   }
}


variable "record_ttl" {
    description = "The TTL of the record"
    default     = 3600
}

variable "record_priority" {
    description = "The priority of the record"
    default     = 1
}

variable "record_proxied" {
    description = "Whether the record gets Cloudflare's origin protection."
    default     = false
}
