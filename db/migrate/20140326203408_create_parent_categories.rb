class CreateParentCategories < ActiveRecord::Migration
  def change
    create_table :parent_categories do |t|
      t.integer :display_order
      t.string :name
      t.string :description

      t.timestamps
    end
  end
end
