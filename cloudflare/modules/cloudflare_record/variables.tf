#-----------------------------------------------------------
# Global or/and default variables
#-----------------------------------------------------------
variable "name" {
    description = " The name of the record"
    default     = "cloudflare_name"
}   

variable "domain" {
    description = "The domain to add the record to"
    default     = ""
}

variable "value" {
    description = "The value of the record. Ex: 192.168.13.113"
    default     = ""
}

variable "type" {
    description = "The type of the record"
    default     = "A"
}

variable "ttl" {
    description = "The TTL of the record"
    default     = 3600
}

variable "priority" {   
    description = "The priority of the record"
    default     = "1"
}

variable "proxied" {
    description = "Whether the record gets Cloudflare's origin protection."
    default     = ""
}
