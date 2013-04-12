require "media_magick/image/dimensions"

class UploaderBase < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick
  include MediaMagick::Image::Dimensions

  storage :file

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end
end
