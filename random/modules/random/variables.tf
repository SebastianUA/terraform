#---------------------------------------------------
# Random uuid
#---------------------------------------------------
variable "enable_uuid" {
  description = "Enable uuid usage"
  default     = false
}

variable "uuid_keepers" {
  description = "(Optional) Arbitrary map of values that, when changed, will trigger a new uuid to be generated. See the main provider documentation for more information."
  default     = null
}

#---------------------------------------------------
# Random string
#---------------------------------------------------
variable "enable_string" {
  description = "Enable string usage"
  default     = false
}

variable "string_length" {
  description = "(Required) The length of the string desired"
  default     = 9
}

variable "string_upper" {
  description = "(Optional) (default true) Include uppercase alphabet characters in random string."
  default     = null
}

variable "string_min_upper" {
  description = "(Optional) (default 0) Minimum number of uppercase alphabet characters in random string."
  default     = null
}

variable "string_lower" {
  description = "(Optional) (default true) Include lowercase alphabet characters in random string."
  default     = null
}

variable "string_min_lower" {
  description = "(Optional) (default 0) Minimum number of lowercase alphabet characters in random string."
  default     = null
}

variable "string_numeric" {
  description = "(Optional) (default true) Include numeric characters in random string."
  default     = null
}

variable "string_min_numeric" {
  description = "(Optional) (default 0) Minimum number of numeric characters in random string."
  default     = null
}

variable "string_special" {
  description = "(Optional) (default true) Include special characters in random string. These are !@#$%&*()-_=+[]{}<>:?"
  default     = null
}

variable "string_min_special" {
  description = "(Optional) (default 0) Minimum number of special characters in random string."
  default     = null
}

variable "string_override_special" {
  description = "(Optional) Supply your own list of special characters to use for string generation. This overrides the default character list in the special argument. The special argument must still be set to true for any overwritten characters to be used in generation."
  default     = null
}

variable "string_keepers" {
  description = "(Optional) Arbitrary map of values that, when changed, will trigger a new id to be generated. See the main provider documentation for more information."
  default     = null
}

#---------------------------------------------------
# Random shuffle
#---------------------------------------------------
variable "enable_shuffle" {
  description = "Enable shuffle usage"
  default     = false
}

variable "shuffle_input" {
  description = "(Required) The list of strings to shuffle."
  default     = []
}

variable "shuffle_result_count" {
  description = "(Optional) The number of results to return. Defaults to the number of items in the input list. If fewer items are requested, some elements will be excluded from the result. If more items are requested, items will be repeated in the result but not more frequently than the number of items in the input list."
  default     = null
}

variable "shuffle_keepers" {
  description = "(Optional) Arbitrary map of values that, when changed, will trigger a new id to be generated. See the main provider documentation for more information."
  default     = null
}

variable "shuffle_seed" {
  description = "(Optional) Arbitrary string with which to seed the random number generator, in order to produce less-volatile permutations of the list. Important: Even with an identical seed, it is not guaranteed that the same permutation will be produced across different versions of Terraform. This argument causes the result to be less volatile, but not fixed for all time."
  default     = null
}

#---------------------------------------------------
# Random pet
#---------------------------------------------------
variable "enable_pet" {
  description = "Enable pet usage"
  default     = false
}

variable "pet_keepers" {
  description = "(Optional) Arbitrary map of values that, when changed, will trigger a new id to be generated. See the main provider documentation for more information."
  default     = null
}

variable "pet_length" {
  description = "(Optional) The length (in words) of the pet name."
  default     = null
}

variable "pet_prefix" {
  description = "(Optional) A string to prefix the name with."
  default     = null
}

variable "pet_separator" {
  description = "(Optional) The character to separate words in the pet name."
  default     = null
}

#---------------------------------------------------
# Random integer
#---------------------------------------------------
variable "enable_integer" {
  description = "Enable integer usage"
  default     = false
}

variable "integer_min" {
  description = "(int) The minimum inclusive value of the range."
  default     = null
}

variable "integer_max" {
  description = "(int) The maximum inclusive value of the range."
  default     = null
}

variable "integer_keepers" {
  description = "(Optional) Arbitrary map of values that, when changed, will trigger a new id to be generated. See the main provider documentation for more information."
  default     = null
}

variable "integer_seed" {
  description = "(Optional) A custom seed to always produce the same value."
  default     = null
}

#---------------------------------------------------
# Random password
#---------------------------------------------------
variable "enable_password" {
  description = "Enable password usage"
  default     = false
}

variable "password_length" {
  description = "(Required) Set length for password"
  default     = null
}

variable "password_special" {
  description = "Set special for password"
  default     = null
}

variable "password_override_special" {
  description = "Set override special for password"
  default     = null
}

variable "password_keepers" {
  description = "Set keepers for password"
  default     = null
}

variable "password_lower" {
  description = "Set keepers lower usage for password"
  default     = null
}

variable "password_min_lower" {
  description = "Set min lower"
  default     = null
}

variable "password_min_numeric" {
  description = "Set min numeric"
  default     = null
}

variable "password_min_special" {
  description = "Set min special"
  default     = null
}

variable "password_min_upper" {
  description = "Set min upper"
  default     = null
}

variable "password_numeric" {
  description = "Set numbers"
  default     = null
}

variable "password_upper" {
  description = "Set upper"
  default     = null
}

#---------------------------------------------------
# Random id
#---------------------------------------------------
variable "enable_id" {
  description = "Enable id usage"
  default     = false
}

variable "id_byte_length" {
  description = "(Required) The number of random bytes to produce. The minimum value is 1, which produces eight bits of randomness."
  default     = null
}

variable "id_keepers" {
  description = "(Optional) Arbitrary map of values that, when changed, will trigger a new id to be generated. See the main provider documentation for more information."
  default     = null
}

variable "id_prefix" {
  description = "(Optional) Arbitrary string to prefix the output value with. This string is supplied as-is, meaning it is not guaranteed to be URL-safe or base64 encoded."
  default     = null
}
