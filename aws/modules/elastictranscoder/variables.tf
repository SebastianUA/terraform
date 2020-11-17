#-----------------------------------------------------------
# Global or/and default variables
#-----------------------------------------------------------
variable "name" {
  description = "Name to be used on all resources as prefix"
  default     = "TEST"
}

variable "environment" {
  description = "Environment for service"
  default     = "STAGE"
}

# variable "tags" {
#     description = "A list of tag blocks. Each element should have keys named key, value, etc."
#     type        = map(string)
#     default     = {}
# }

#---------------------------------------------------
# AWS elastictranscoder pipeline
#---------------------------------------------------
variable "enable_elastictranscoder_pipeline" {
  description = "Enable elastictranscoder pipeline usage"
  default     = false
}

variable "elastictranscoder_pipeline_input_bucket" {
  description = "(Required) The Amazon S3 bucket in which you saved the media files that you want to transcode and the graphics that you want to use as watermarks."
  default     = ""
}

variable "elastictranscoder_pipeline_role" {
  description = "(Required) The IAM Amazon Resource Name (ARN) for the role that you want Elastic Transcoder to use to transcode jobs for this pipeline."
  default     = ""
}

variable "elastictranscoder_pipeline_name" {
  description = "(Optional, Forces new resource) The name of the pipeline. Maximum 40 characters"
  default     = ""
}

variable "elastictranscoder_pipeline_output_bucket" {
  description = "(Optional) The Amazon S3 bucket in which you want Elastic Transcoder to save the transcoded files."
  default     = null
}

variable "elastictranscoder_pipeline_aws_kms_key_arn" {
  description = "(Optional) The AWS Key Management Service (AWS KMS) key that you want to use with this pipeline."
  default     = null
}

variable "elastictranscoder_pipeline_content_config" {
  description = "(Optional) The ContentConfig object specifies information about the Amazon S3 bucket in which you want Elastic Transcoder to save transcoded files and playlists. "
  default     = []
}

variable "elastictranscoder_pipeline_content_config_permissions" {
  description = "(Optional) The permissions for the content_config object. "
  default     = []
}

variable "elastictranscoder_pipeline_notifications" {
  description = "(Optional) The Amazon Simple Notification Service (Amazon SNS) topic that you want to notify to report job status."
  default     = []
}

variable "elastictranscoder_pipeline_thumbnail_config" {
  description = "(Optional) The ThumbnailConfig object specifies information about the Amazon S3 bucket in which you want Elastic Transcoder to save thumbnail files."
  default     = []
}

variable "elastictranscoder_pipeline_thumbnail_config_permissions" {
  description = "(Optional) The permissions for the thumbnail_config object."
  default     = []
}

#---------------------------------------------------
# AWS elastictranscoder preset
#---------------------------------------------------
variable "enable_elastictranscoder_preset" {
  description = "Enable elastictranscoder preset usage"
  default     = false
}

variable "elastictranscoder_preset_container" {
  description = "(Required, Forces new resource) The container type for the output file. Valid values are flac, flv, fmp4, gif, mp3, mp4, mpg, mxf, oga, ogg, ts, and webm."
  default     = "mp4"
}

variable "elastictranscoder_preset_name" {
  description = "(Optional, Forces new resource) The name of the preset. (maximum 40 characters)"
  default     = ""
}

variable "elastictranscoder_preset_description" {
  description = "(Optional, Forces new resource) A description of the preset (maximum 255 characters)"
  default     = null
}

variable "elastictranscoder_preset_audio" {
  description = "(Optional, Forces new resource) Audio parameters object"
  default     = []
}

variable "elastictranscoder_preset_audio_codec_options" {
  description = "(Optional, Forces new resource) Codec options for the audio parameters"
  default     = []
}

variable "elastictranscoder_preset_thumbnails" {
  description = "(Optional, Forces new resource) Thumbnail parameters object"
  default     = []
}

variable "elastictranscoder_preset_video" {
  description = "(Optional, Forces new resource) Video parameters object "
  default     = []
}

variable "elastictranscoder_preset_video_watermarks" {
  description = "(Optional, Forces new resource) Watermark parameters for the video parameters"
  default     = []
}

# variable "elastictranscoder_preset_video_codec_options" {
#   description   = "(Optional, Forces new resource) Codec options for the video parameters"
#   default       = []
# }
