class Item < ActiveRecord::Base
  belongs_to :category
  #belongs_to :parent_category through :category

  include Orderable

  before_save :reset_display_order
  before_destroy :shuffle_up
  after_initialize :set_orderable_fields

  attr_accessor :order_field, :parent_id

  has_attached_file :photo, styles: { small: "200", medium: "300", large: "400", xlarge: "500", xxlarge: "600" }, default_url: "/images/:style/missing.png"
  #validates :photo, :attachment_presence => true
  validates_with AttachmentContentTypeValidator, attributes: :photo, content_type: ['image/jpeg', 'image/jpg', 'image/png']

  private

  def set_orderable_fields
    orderable :display_order, :category_id
  end
end
