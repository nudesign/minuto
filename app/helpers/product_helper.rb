module ProductHelper
  def first_image(product, format, args={})

    format ||= :thumb_list

    image_path =  if product && product.photos.first
                    product.photos.first.photo.url(format.to_sym)
                  else "mine-thumb11.jpg" end

    image_tag(image_path, args)
  end

  def products_by_mine(mine)
    limit = 4
    _products = mine.products.limit(limit)

    html = ''
    (0..limit-1).each do |index|
      html << first_image(_products[index], nil, class: "list-item-thumb micro-thumb")
    end

    html.html_safe
  end
end