class ProductUploader < UploaderBase
  version :thumb_list do
    process resize_to_fill: [95, 95]
  end

  version :size_1x1 do
    process resize_to_fill: [196, 196]
  end

  version :size_1x2 do
    process resize_to_fill: [196, 396]
  end

  version :size_2x1 do
    process resize_to_fill: [396, 196]
  end

  version :size_2x2 do
    process resize_to_fill: [396, 396]
  end
end
