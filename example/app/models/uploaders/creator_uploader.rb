class CreatorUploader < UploaderBase
  version :thumb do
    process :resize_to_fill => [56, 56]
  end
end
