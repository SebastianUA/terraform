#
# MAINTAINER Vitaliy Natarov "vitaliy.natarov@yahoo.com"
#
terraform {
  required_version = ">= 0.12.12"
}

provider "aws" {
    region                  = "us-west-2"
    shared_credentials_file = pathexpand("~/.aws/credentials")
    profile                 = "default"
}

module "elasticbeanstalk" {
    source                                      = "../../modules/elasticbeanstalk"
    name                                        = "TESTmeNow"
    region                                      = "us-west-2"
    environment                                 = "PROD"

    enable_elastic_beanstalk_application        = true
    elastic_beanstalk_application_name          = ""
    elastic_beanstalk_application_description   = ""
    appversion_lifecycle                        = []

    enable_elastic_beanstalk_environment        = true
    elastic_beanstalk_environment_name          = ""
    elastic_beanstalk_environment_description   = ""
    application_name                            = ""


}
