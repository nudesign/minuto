class Creator
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Slug
  include Mongoid::Textile
  include Mongoid::LolFinder
  include Mongoid::Sortable
  include MediaMagick::Model

  CATEGORIES = %w(art architecture design photography fashion)

  field :name
  field :location
  field :occupation
  field :release
  field :interview
  field :main_category
  field :categories, type: Array, default: []
  field :published_at, type: Date

  has_many :galleries

  slug :name

  textlize :release
  textlize :interview

  find_for :name

  attaches_many :photos, uploader: CreatorUploader

  delegate :published, to: :galleries, prefix: true

  scope :published, where(state: :published, :published_at.lte => Date.today)
  scope :approved, where(:state.nin => [:unapproved])
  scope :portfolios, where(state: :unapproved)

  scope :by_category, ->(category) do
    scoped.or(:categories.in => [category]).
    or(main_category: category)
  end

  state_machine :state, initial: :unapproved do
    state :draft
    state :published
  end

  state_machine :step, initial: :first_step do
    state :second_step, :finished do
      validates :name, :location, :occupation,
                :release, :interview, :main_category, presence: true
    end

    event :second_step do
      transition :first_step => :second_step
    end
  end

  before_validation :touch_published_at

  def self.list(includes_drafts=true)
    includes_drafts ? all : published
  end

  def self.newest
    newest_creators = CATEGORIES.inject([]) do |list, category|
      list.push(newest_for_category(category))
    end.compact

    newest_creators + exclude_list(newest_creators)
  end

  def avatar
    photos.first if photos.present?
  end

  def have_gallery_with_photos?
    galleries.present? && galleries.first.photos?
  end

  def cover_gallery_photo
    galleries.first.photos.first
  end

  private

  def touch_published_at
    self.published_at = Date.today if published? and !published_at.present?
  end

  def self.newest_for_category(category)
    published.asc(:priority).where(main_category: category).limit(1).first
  end

  def self.exclude_list(creators)
    return [] if creators.blank?

    ids = creators.map(&:id)
    published.asc(:priority).where(:id.nin => ids).to_a
  end
end
