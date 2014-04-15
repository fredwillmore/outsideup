class ParentCategory < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, use: [:slugged, :finders]

  has_many :category

  has_attached_file :photo, styles: { medium: "190", thumb: "80", large: "400" }, default_url: "/images/:style/missing.png"
  #validates :photo, :attachment_presence => true
  validates_with AttachmentContentTypeValidator, attributes: :photo, content_type: ['image/jpeg', 'image/jpg', 'image/png']

  def should_generate_new_friendly_id?
    name_changed? || slug.nil?
  end

  def categories
    Category.where parent_category_id: id
  end
end
