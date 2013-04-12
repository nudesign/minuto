class GalleryUploader < UploaderBase
  version :list do
    process :resize_to_fill => [196, 296]
  end

  version :thumb do
    process :resize_to_fill => [184, 128]
  end

  version :gallery do
    process :resize_to_limit => [984, 608]
  end

  version :gallery_thumb do
    process :resize_to_fill => [72, 48]
  end
end
