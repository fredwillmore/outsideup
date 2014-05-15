class Category < ActiveRecord::Base
  belongs_to :parent_category
  has_many :item

  include Orderable

  def initialize
    super
    orderable :display_order, :parent_category_id
  end
  before_save :reset_display_order
  before_destroy :shuffle_up

  def items
    Item.where(category_id: id).order :display_order
  end
end
