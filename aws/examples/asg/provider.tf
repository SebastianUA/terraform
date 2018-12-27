terraform {
    required_version = "> 0.9.0"
    #backend "s3" {
    #    bucket  = "npsops-prod"
    #    key     = "terraform/v2/prod/api-3/cassandra.tfstate"
    #    region  = "us-west-2"
    #    profile = "default"
    #}
}

provider "aws" {
    region  = "us-west-2"
    profile = "default"
    # Make it faster by skipping something
    #skip_get_ec2_platforms      = true
    #skip_metadata_api_check     = true
    #skip_region_validation      = true
    #skip_credentials_validation = true
    #skip_requesting_account_id  = true
}

