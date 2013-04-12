class Mine
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Slug
  include Mongoid::Publish

  # FIELDS
  field :title
  field :resume

  slug :title

  # SCOPES
  scope :newest, order_by(created_at: :desc)

  # RELATIONSHIPS
  embeds_many :products

  # VALIDATES
  validates :title, presence: true
end
