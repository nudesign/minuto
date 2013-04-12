class Gallery
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Slug
  include MediaMagick::Model

  field :title
  field :published_at, type: Date

  validates :title, presence: true

  belongs_to :creator

  slug :title

  attaches_many :photos, uploader: GalleryUploader, allow_videos: true

  default_scope order_by('created_at DESC')
  scope :published, where(state: :published, :published_at.lte => Date.today)

  state_machine :state, initial: :unapproved do
    state :draft
    state :published
  end

  before_validation :touch_published_at

  private

  def touch_published_at
    self.published_at = Date.today if published? and !published_at.present?
  end
end
