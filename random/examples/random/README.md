# Work with RANDOM via terraform

A terraform module for making RANDOM.


## Usage
----------------------
Import the module and retrieve with ```terraform get``` or ```terraform get --update```. Adding a module resource to your template, e.g. `main.tf`:

```
#
# MAINTAINER Vitaliy Natarov "vitaliy.natarov@yahoo.com"
#
terraform {
  required_version = "~> 1.0"
}


module "random" {
  source = "../../modules/random"

  # Generate ramdom UUID
  enable_uuid  = true
  uuid_keepers = {}

  # Generate random string
  enable_string = true
  string_length = 66

  # Generate random shuffle
  enable_shuffle       = true
  shuffle_input        = ["us-east-1", "us-east-2", "us-west-1", "us-west-2"]
  shuffle_result_count = 2

  # Generate random pet
  enable_pet = true
  pet_length = 6

  # Generate random integer
  enable_integer = true
  integer_min    = 1
  integer_max    = 50000

  # Generate random password
  enable_password           = true
  password_length           = 13
  password_special          = true
  password_override_special = "_%@"

  # Generate random id
  enable_id      = true
  id_byte_length = 8

}

```

## Module Input Variables
----------------------
- `enable_uuid` - Enable uuid usage (`default = False`)
- `uuid_keepers` - (Optional) Arbitrary map of values that, when changed, will trigger a new uuid to be generated. See the main provider documentation for more information. (`default = null`)
- `enable_string` - Enable string usage (`default = False`)
- `string_length` - (Required) The length of the string desired (`default = 9`)
- `string_upper` - (Optional) (default true) Include uppercase alphabet characters in random string. (`default = null`)
- `string_min_upper` - (Optional) (default 0) Minimum number of uppercase alphabet characters in random string. (`default = null`)
- `string_lower` - (Optional) (default true) Include lowercase alphabet characters in random string. (`default = null`)
- `string_min_lower` - (Optional) (default 0) Minimum number of lowercase alphabet characters in random string. (`default = null`)
- `string_numeric` - (Optional) (default true) Include numeric characters in random string. (`default = null`)
- `string_min_numeric` - (Optional) (default 0) Minimum number of numeric characters in random string. (`default = null`)
- `string_special` - (Optional) (default true) Include special characters in random string. These are !@#$%&*()-_=+[]{}<>:? (`default = null`)
- `string_min_special` - (Optional) (default 0) Minimum number of special characters in random string. (`default = null`)
- `string_override_special` - (Optional) Supply your own list of special characters to use for string generation. This overrides the default character list in the special argument. The special argument must still be set to true for any overwritten characters to be used in generation. (`default = null`)
- `string_keepers` - (Optional) Arbitrary map of values that, when changed, will trigger a new id to be generated. See the main provider documentation for more information. (`default = null`)
- `enable_shuffle` - Enable shuffle usage (`default = False`)
- `shuffle_input` - (Required) The list of strings to shuffle. (`default = []`)
- `shuffle_result_count` - (Optional) The number of results to return. Defaults to the number of items in the input list. If fewer items are requested, some elements will be excluded from the result. If more items are requested, items will be repeated in the result but not more frequently than the number of items in the input list. (`default = null`)
- `shuffle_keepers` - (Optional) Arbitrary map of values that, when changed, will trigger a new id to be generated. See the main provider documentation for more information. (`default = null`)
- `shuffle_seed` - (Optional) Arbitrary string with which to seed the random number generator, in order to produce less-volatile permutations of the list. Important: Even with an identical seed, it is not guaranteed that the same permutation will be produced across different versions of Terraform. This argument causes the result to be less volatile, but not fixed for all time. (`default = null`)
- `enable_pet` - Enable pet usage (`default = False`)
- `pet_keepers` - (Optional) Arbitrary map of values that, when changed, will trigger a new id to be generated. See the main provider documentation for more information. (`default = null`)
- `pet_length` - (Optional) The length (in words) of the pet name. (`default = null`)
- `pet_prefix` - (Optional) A string to prefix the name with. (`default = null`)
- `pet_separator` - (Optional) The character to separate words in the pet name. (`default = null`)
- `enable_integer` - Enable integer usage (`default = False`)
- `integer_min` - (int) The minimum inclusive value of the range. (`default = null`)
- `integer_max` - (int) The maximum inclusive value of the range. (`default = null`)
- `integer_keepers` - (Optional) Arbitrary map of values that, when changed, will trigger a new id to be generated. See the main provider documentation for more information. (`default = null`)
- `integer_seed` - (Optional) A custom seed to always produce the same value. (`default = null`)
- `enable_password` - Enable password usage (`default = False`)
- `password_length` - (Required) Set length for password (`default = null`)
- `password_special` - Set special for password (`default = null`)
- `password_override_special` - Set override special for password (`default = null`)
- `password_keepers` - Set keepers for password (`default = null`)
- `password_lower` - Set keepers lower usage for password (`default = null`)
- `password_min_lower` - Set min lower (`default = null`)
- `password_min_numeric` - Set min numeric (`default = null`)
- `password_min_special` - Set min special (`default = null`)
- `password_min_upper` - Set min upper (`default = null`)
- `password_numeric` - Set numbers (`default = null`)
- `password_upper` - Set upper (`default = null`)
- `enable_id` - Enable id usage (`default = False`)
- `id_byte_length` - (Required) The number of random bytes to produce. The minimum value is 1, which produces eight bits of randomness. (`default = null`)
- `id_keepers` - (Optional) Arbitrary map of values that, when changed, will trigger a new id to be generated. See the main provider documentation for more information. (`default = null`)
- `id_prefix` - (Optional) Arbitrary string to prefix the output value with. This string is supplied as-is, meaning it is not guaranteed to be URL-safe or base64 encoded. (`default = null`)

## Module Output Variables
----------------------
- `uuid_id` - The ID of uuid
- `uuid_result` - The generated uuid presented in string format.
- `string_id` - The ID of string
- `string_result` - Random string generated.
- `shuffle_id` - The ID of shuffle
- `shuffle_result` - Random permutation of the list of strings given in input.
- `pet_id` - (string) The random pet name
- `integer_id` - (string) An internal id.
- `integer_result` - (int) The random Integer result.
- `password_result` - The random password result.
- `id_b64_url` - The generated id presented in base64, using the URL-friendly character set: case-sensitive letters, digits and the characters _ and -.
- `id_b64_std` - The generated id presented in base64 without additional transformations.
- `id_hex` - The generated id presented in padded hexadecimal digits. This result will always be twice as long as the requested byte length.
- `id_dec` - The generated id presented in non-padded decimal digits.


## Authors

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA). An email: [vitaliy.natarov@yahoo.com](vitaliy.natarov@yahoo.com).

## License

Apache 2 Licensed. See [LICENSE](https://github.com/SebastianUA/terraform/blob/master/LICENSE) for full details.
