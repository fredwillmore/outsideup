class ParentCategory < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, use: [:slugged, :finders]

  has_many :category, dependent: :destroy

  has_attached_file :photo, styles: { small: "200", medium: "300", large: "400" }, default_url: "/images/:style/missing.png"
  #validates :photo, :attachment_presence => true
  validates_with AttachmentContentTypeValidator, attributes: :photo, content_type: ['image/jpeg', 'image/jpg', 'image/png']

  include Orderable

  before_save :reset_display_order
  before_destroy :shuffle_up
  after_initialize :set_orderable_fields

  attr_accessor :order_field, :parent_id

  def should_generate_new_friendly_id?
    name_changed? || slug.nil?
  end

  def categories
    Category.where parent_category_id: id
  end

  private

  def set_orderable_fields
    orderable :display_order
  end
end
