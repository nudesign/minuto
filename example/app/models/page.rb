class Page
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Slug
  include Mongoid::Textile

  field :title
  field :description
  field :type

  validates :title, :description, :type, presence: true

  slug :type

  textlize :title
  textlize :description

  scope :find_for, ->(type){ where(type: type) }
end
