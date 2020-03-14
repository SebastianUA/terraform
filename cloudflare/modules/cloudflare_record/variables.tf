#-----------------------------------------------------------
# Global or/and default variables
#-----------------------------------------------------------
variable "enable_cloudflare_record" {
    description = "Enable cloudflare record usage"
    default     = false
}

variable "enable_cloudflare_record_data" {
    description = "Enable cloudflare record usage"
    default     = false
}

variable "name" {
    description = "The name of the record"
    default     = "cloudflare_name"
}

variable "zone_id" {
    description = "(Required) The DNS zone ID to add the record to"
    default     = ""
}

variable "type" {
    description = "The type of the record"
    default     = "A"
}

variable "value" {
    description = "The value of the record. Ex: 192.168.13.113"
    default     = ""
}

variable "data" {
  description   = "description"
  #type          = "map"
  default       = {
    service  = "_sip"
    proto    = "_tls"
    name     = "terraform-srv"
    priority = 0
    weight   = 0
    port     = 443
    target   = "linux-notes.org"
  }
}


variable "ttl" {
    description = "The TTL of the record"
    default     = 3600
}

variable "priority" {
    description = "The priority of the record"
    default     = 1
}

variable "proxied" {
    description = "Whether the record gets Cloudflare's origin protection."
    default     = false
}
