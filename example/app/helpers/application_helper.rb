module ApplicationHelper
  def is_sortable?(condition)
    "list-sortable" if condition
  end
end
