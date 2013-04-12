# encoding: utf-8

module CreatorHelper
  def creator_preview_data(creator)
    info = {
      name:       creator.name,
      location:   creator.location,
      occupation: creator.occupation,
      release:    truncate(creator.release_formatted, length: 300),
      interview:  creator.interview_formatted,
      categories: creator.categories,
    }

    info.merge!(avatar: creator.avatar.thumb.url) if creator.avatar.present?
    return info.to_json
  end

  def filtered_category(category_name)
    return t("category.#{category_name}") if category_name
    "selecionar área"
  end

  def search_placeholder(value)
    return value if value
    "busca"
  end
end