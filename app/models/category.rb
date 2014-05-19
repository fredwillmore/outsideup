class Category < ActiveRecord::Base
  belongs_to :parent_category
  has_many :items, dependent: :destroy

  include Orderable

  before_save :reset_display_order
  before_destroy :shuffle_up
  after_initialize :set_orderable_fields

  attr_accessor :order_field, :parent_id

  def items
    Item.where(category_id: id).order :display_order
  end

  private

  def set_orderable_fields
    orderable :display_order, :parent_category_id
  end
end
