class Category < ActiveRecord::Base
  belongs_to :parent_category
  has_many :item

  def items
    Item.where(category_id: id).order :display_order
  end
end
