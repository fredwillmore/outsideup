class ParentCategory < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, use: [:slugged, :finders]

  has_many :category

  has_attached_file :photo, styles: { small: "200", medium: "300", large: "400" }, default_url: "/images/:style/missing.png"
  #validates :photo, :attachment_presence => true
  validates_with AttachmentContentTypeValidator, attributes: :photo, content_type: ['image/jpeg', 'image/jpg', 'image/png']

  include Orderable

  def initialize
    super
    orderable :display_order
  end
  before_save :reset_display_order
  before_destroy :shuffle_up

  def should_generate_new_friendly_id?
    name_changed? || slug.nil?
  end

  def categories
    Category.where parent_category_id: id
  end

  after_initialize :init

  def inc
    self.increment! :display_order, 1
  end

  def dec
    self.decrement! :display_order, 1
  end

  def get_display_order
    self.display_order ||= ParentCategory.order("display_order DESC").first.display_order+1 rescue 1 #will set the default value only if it's nil
  end

  def init
    get_display_order
  end
end
