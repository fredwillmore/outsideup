class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.integer :display_order
      t.string :name
      t.string :description
      t.integer :parent_category_id

      t.timestamps
    end
  end
end
