class Product
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Slug
  include Mongoid::Publish
  include MediaMagick::Model

  CATEGORIES = %w(art architecture design fashion)
  SIZES = %w(1x1 2x2 2x1 1x2)

  # FIELDS
  field :name
  field :store_name
  field :store_link
  field :price
  field :size
  field :main_category
  field :categories, type: Array, default: []

  slug :name

  # RELATIONSHIPS
  embedded_in :mine
  attaches_many :photos, uploader: ProductUploader

  # VALIDATES
  validates :name, presence: true
end
