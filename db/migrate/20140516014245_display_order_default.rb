class DisplayOrderDefault < ActiveRecord::Migration
  def change
    change_column :items, :display_order, :integer, default: 0
    change_column :categories, :display_order, :integer, default: 0
    change_column :parent_categories, :display_order, :integer, default: 0
  end
end
