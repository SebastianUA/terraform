#---------------------------------------------------
# Create AWS key pair
#---------------------------------------------------
resource "aws_key_pair" "key_pair_key_name" {
    count           = "${var.enable_key_pair && length(var.key_name) !="" ? 1 : 0}"
    
    key_name        = "${var.key_name}"
    public_key      = "${var.public_key}"

    lifecycle {
        create_before_destroy   = true
        ignore_changes          = []
    }

    depends_on = []

}

resource "aws_key_pair" "key_pair_key_name_prefix" {
    count           = "${var.enable_key_pair && length(var.key_name) =="" ? 1 : 0}"

    key_name_prefix = "${var.key_name_prefix}"
    public_key      = "${var.public_key}"

    lifecycle {
        create_before_destroy   = true
        ignore_changes          = []
    }

    depends_on = []

}

