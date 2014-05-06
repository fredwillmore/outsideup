class Item < ActiveRecord::Base
  belongs_to :category
  #belongs_to :parent_category through :category

  has_attached_file :photo, styles: { medium: "190", thumb: "80", large: "400" }, default_url: "/images/:style/missing.png"
  #validates :photo, :attachment_presence => true
  validates_with AttachmentContentTypeValidator, attributes: :photo, content_type: ['image/jpeg', 'image/jpg', 'image/png']

  after_initialize :init

  def inc
    self.increment! :display_order, 1
  end

  def dec
    self.decrement! :display_order, 1
  end

  def get_display_order
    self.display_order ||= Item.where(category_id: self.category_id).order("display_order DESC").first.display_order+1 rescue 1 #will set the default value only if it's nil
  end

  def init
    get_display_order
  end

end
