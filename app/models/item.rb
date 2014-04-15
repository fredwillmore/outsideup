class Item < ActiveRecord::Base
  belongs_to :category
  #belongs_to :parent_category through :category

  has_attached_file :photo, styles: { medium: "190", thumb: "80", large: "400" }, default_url: "/images/:style/missing.png"
  #validates :photo, :attachment_presence => true
  validates_with AttachmentContentTypeValidator, attributes: :photo, content_type: ['image/jpeg', 'image/jpg', 'image/png']
end
