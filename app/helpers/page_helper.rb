module PageHelper
  def edit_or_create_page_for(type)
    if Page.find_for(type).present?
      edit_page_path(type)
    else
      new_page_path(type)
    end
  end
end
