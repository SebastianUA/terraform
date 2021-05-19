#---------------------------------------------------
# AWS elastictranscoder preset
#---------------------------------------------------
resource "aws_elastictranscoder_preset" "elastictranscoder_preset" {
  count = var.enable_elastictranscoder_preset ? 1 : 0

  container = lower(var.elastictranscoder_preset_container)

  name        = var.elastictranscoder_preset_name != null ? lower(var.elastictranscoder_preset_name) : "${lower(var.name)}-elastictranscoder-preset-${lower(var.environment)}"
  description = var.elastictranscoder_preset_description

  dynamic "audio" {
    iterator = audio
    for_each = var.elastictranscoder_preset_audio

    content {
      audio_packing_mode = lookup(audio.value, "audio_packing_mode", null)
      bit_rate           = lookup(audio.value, "bit_rate", null)
      channels           = lookup(audio.value, "channels", null)
      codec              = lookup(audio.value, "codec", null)
      sample_rate        = lookup(audio.value, "sample_rate", null)
    }
  }

  dynamic "audio_codec_options" {
    iterator = audio_codec_options
    for_each = var.elastictranscoder_preset_audio_codec_options

    content {
      profile   = lookup(audio_codec_options.value, "profile", null)
      bit_depth = lookup(audio_codec_options.value, "bit_depth", null)
      bit_order = lookup(audio_codec_options.value, "bit_order", null)
      signed    = lookup(audio_codec_options.value, "signed", null)
    }
  }

  dynamic "thumbnails" {
    iterator = thumbnails
    for_each = var.elastictranscoder_preset_thumbnails

    content {
      format         = lookup(thumbnails.value, "format", null)
      interval       = lookup(thumbnails.value, "interval", null)
      max_width      = lookup(thumbnails.value, "max_width", null)
      max_height     = lookup(thumbnails.value, "max_height", null)
      padding_policy = lookup(thumbnails.value, "padding_policy", null)
      sizing_policy  = lookup(thumbnails.value, "sizing_policy", null)
    }
  }

  dynamic "video" {
    iterator = video
    for_each = var.elastictranscoder_preset_video

    content {
      aspect_ratio         = lookup(video.value, "aspect_ratio", null)
      bit_rate             = lookup(video.value, "bit_rate", null)
      codec                = lookup(video.value, "codec", null)
      display_aspect_ratio = lookup(video.value, "display_aspect_ratio", null)
      fixed_gop            = lookup(video.value, "fixed_gop", null)
      frame_rate           = lookup(video.value, "frame_rate", null)
      keyframes_max_dist   = lookup(video.value, "keyframes_max_dist", null)
      max_frame_rate       = lookup(video.value, "max_frame_rate", null)
      max_height           = lookup(video.value, "max_height", null)
      max_width            = lookup(video.value, "max_width", null)
      padding_policy       = lookup(video.value, "padding_policy", null)
      resolution           = lookup(video.value, "resolution", null)
      sizing_policy        = lookup(video.value, "sizing_policy", null)
    }
  }

  dynamic "video_watermarks" {
    iterator = video_watermarks
    for_each = var.elastictranscoder_preset_video_watermarks

    content {
      id                = lookup(video_watermarks.value, "id", null)
      max_width         = lookup(video_watermarks.value, "max_width", null)
      max_height        = lookup(video_watermarks.value, "max_height", null)
      sizing_policy     = lookup(video_watermarks.value, "sizing_policy", null)
      horizontal_align  = lookup(video_watermarks.value, "horizontal_align", null)
      horizontal_offset = lookup(video_watermarks.value, "horizontal_offset", null)
      vertical_align    = lookup(video_watermarks.value, "vertical_align", null)
      vertical_offset   = lookup(video_watermarks.value, "vertical_offset", null)
      opacity           = lookup(video_watermarks.value, "opacity", null)
      target            = lookup(video_watermarks.value, "target", null)
    }
  }

  # dynamic "video_codec_options" {
  #     iterator = video_codec_options
  #     for_each = var.elastictranscoder_preset_video_codec_options
  #     content {
  #         Profile                 = lookup(video_codec_options.value, "Profile", null)
  #         Level                   = lookup(video_codec_options.value, "Level", null)
  #         MaxReferenceFrames      = lookup(video_codec_options.value, "MaxReferenceFrames", null)
  #         MaxBitRate              = lookup(video_codec_options.value, "MaxBitRate", null)
  #         BufferSize              = lookup(video_codec_options.value, "BufferSize", null)
  #         InterlacedMode          = lookup(video_codec_options.value, "InterlacedMode", null)
  #         ColorSpaceConversion    = lookup(video_codec_options.value, "ColorSpaceConversion", null)
  #         ChromaSubsampling       = lookup(video_codec_options.value, "ChromaSubsampling", null)
  #         LoopCount               = lookup(video_codec_options.value, "LoopCount", null)
  #     }
  # }

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}
