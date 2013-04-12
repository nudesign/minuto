class Inspiration
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Slug
  include Mongoid::Textile
  include Mongoid::Publish
  include Mongoid::LolFinder
  include Mongoid::Document::Taggable
  include MediaMagick::Model

  CATEGORIES = %w(art architecture design fashion)

  field :title
  field :tags, type: Array
  field :resume
  field :description
  field :main_category
  field :categories, type: Array, default: []
  field :highlight, type: Boolean, default: false

  slug :title
  validates :title, :resume, :description, :main_category, presence: true

  textlize :resume
  textlize :description

  find_for :title

  attaches_many :photos, uploader: GalleryUploader, allow_videos: true

  default_scope order_by('created_at DESC')

  scope :highlight, published.where(highlight: true)
  scope :without_highlight, ->(highlight) { where(:id.ne => highlight.id) }

  def cover
    photos.first if photos.present?
  end

  def self.first_highlight
    highlight.limit(1).first
  end
end
