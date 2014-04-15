class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.integer :display_order
      t.string :name
      t.string :description
      t.integer :category_id

      t.timestamps
    end
  end
end
