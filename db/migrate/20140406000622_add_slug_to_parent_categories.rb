class AddSlugToParentCategories < ActiveRecord::Migration
  def change
    add_column :parent_categories, :slug, :string
    add_index :parent_categories, :slug
  end
end
