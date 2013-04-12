class Search
  def initialize(criteria)
    @criteria = criteria
  end

  def filter(query)
    @criteria.search(query)
  end
end