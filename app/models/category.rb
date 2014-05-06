class Category < ActiveRecord::Base
  belongs_to :parent_category
  has_many :item

  def items
    Item.where(category_id: id).order :display_order
  end

  after_initialize :init

  def inc
    self.increment! :display_order, 1
  end

  def dec
    self.decrement! :display_order, 1
  end

  def get_display_order
    self.display_order ||= Category.where(parent_category_id: self.parent_category_id).order("display_order DESC").first.display_order+1 rescue 1 #will set the default value only if it's nil
  end

  def init
    get_display_order
  end
end
