# Work with ELASTICTRANSCODER via terraform

A terraform module for making ELASTICTRANSCODER.


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

provider "aws" {
  region                  = "us-east-1"
  shared_credentials_file = pathexpand("~/.aws/credentials")
}

module "elastictranscoder" {
  source      = "../../modules/elastictranscoder"
  name        = "TEST"
  environment = "stage"

  # elastictranscoder pipeline
  enable_elastictranscoder_pipeline       = true
  elastictranscoder_pipeline_name         = "test-elastictranscoder-pipeline"
  elastictranscoder_pipeline_input_bucket = "my-test-bucket"
  elastictranscoder_pipeline_role         = "arn:aws:iam::167127734783:role/admin-role"

  # elastictranscoder preset
  enable_elastictranscoder_preset      = true
  elastictranscoder_preset_container   = "m4"
  elastictranscoder_preset_name        = null
  elastictranscoder_preset_description = null

}

```

## Module Input Variables
----------------------
- `name` - Name to be used on all resources as prefix (`default = TEST`)
- `environment` - Environment for service (`default = STAGE`)
- `enable_elastictranscoder_pipeline` - Enable elastictranscoder pipeline usage (`default = False`)
- `elastictranscoder_pipeline_input_bucket` - (Required) The Amazon S3 bucket in which you saved the media files that you want to transcode and the graphics that you want to use as watermarks. (`default = ""`)
- `elastictranscoder_pipeline_role` - (Required) The IAM Amazon Resource Name (ARN) for the role that you want Elastic Transcoder to use to transcode jobs for this pipeline. (`default = ""`)
- `elastictranscoder_pipeline_name` - (Optional, Forces new resource) The name of the pipeline. Maximum 40 characters (`default = ""`)
- `elastictranscoder_pipeline_output_bucket` - (Optional) The Amazon S3 bucket in which you want Elastic Transcoder to save the transcoded files. (`default = null`)
- `elastictranscoder_pipeline_aws_kms_key_arn` - (Optional) The AWS Key Management Service (AWS KMS) key that you want to use with this pipeline. (`default = null`)
- `elastictranscoder_pipeline_content_config` - (Optional) The ContentConfig object specifies information about the Amazon S3 bucket in which you want Elastic Transcoder to save transcoded files and playlists.  (`default = []`)
- `elastictranscoder_pipeline_content_config_permissions` - (Optional) The permissions for the content_config object.  (`default = []`)
- `elastictranscoder_pipeline_notifications` - (Optional) The Amazon Simple Notification Service (Amazon SNS) topic that you want to notify to report job status. (`default = []`)
- `elastictranscoder_pipeline_thumbnail_config` - (Optional) The ThumbnailConfig object specifies information about the Amazon S3 bucket in which you want Elastic Transcoder to save thumbnail files. (`default = []`)
- `elastictranscoder_pipeline_thumbnail_config_permissions` - (Optional) The permissions for the thumbnail_config object. (`default = []`)
- `enable_elastictranscoder_preset` - Enable elastictranscoder preset usage (`default = False`)
- `elastictranscoder_preset_container` - (Required, Forces new resource) The container type for the output file. Valid values are flac, flv, fmp4, gif, mp3, mp4, mpg, mxf, oga, ogg, ts, and webm. (`default = mp4`)
- `elastictranscoder_preset_name` - (Optional, Forces new resource) The name of the preset. (maximum 40 characters) (`default = ""`)
- `elastictranscoder_preset_description` - (Optional, Forces new resource) A description of the preset (maximum 255 characters) (`default = null`)
- `elastictranscoder_preset_audio` - (Optional, Forces new resource) Audio parameters object (`default = []`)
- `elastictranscoder_preset_audio_codec_options` - (Optional, Forces new resource) Codec options for the audio parameters (`default = []`)
- `elastictranscoder_preset_thumbnails` - (Optional, Forces new resource) Thumbnail parameters object (`default = []`)
- `elastictranscoder_preset_video` - (Optional, Forces new resource) Video parameters object  (`default = []`)
- `elastictranscoder_preset_video_watermarks` - (Optional, Forces new resource) Watermark parameters for the video parameters (`default = []`)

## Module Output Variables
----------------------
- `elastictranscoder_pipeline_id` - ID of elastictranscoder pipeline
- `elastictranscoder_preset_id` - ID of elastictranscoder preset


## Authors

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA). An email: [vitaliy.natarov@yahoo.com](vitaliy.natarov@yahoo.com).

## License

Apache 2 Licensed. See [LICENSE](https://github.com/SebastianUA/terraform/blob/master/LICENSE) for full details.
