class Item < ActiveRecord::Base
  belongs_to :category
  #belongs_to :parent_category through :category

  include Orderable

  def initialize
    super
    orderable :display_order, :parent_category_id
  end
  before_save :reset_display_order
  before_destroy :shuffle_up

  has_attached_file :photo, styles: { small: "200", medium: "300", large: "400" }, default_url: "/images/:style/missing.png"
  #validates :photo, :attachment_presence => true
  validates_with AttachmentContentTypeValidator, attributes: :photo, content_type: ['image/jpeg', 'image/jpg', 'image/png']

end
