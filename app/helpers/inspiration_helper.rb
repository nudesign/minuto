module InspirationHelper
  def tag_list
    # problem: map/reduce doesn't work with sort default scope
    Inspiration.unscoped.
      where(:published => true, :published_at.lte => Date.today).
      all_tags.collect{|h| h[:name]}
  end
end
