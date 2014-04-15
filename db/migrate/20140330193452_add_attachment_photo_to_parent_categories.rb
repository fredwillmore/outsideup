class AddAttachmentPhotoToParentCategories < ActiveRecord::Migration
  def self.up
    change_table :parent_categories do |t|
      t.attachment :photo
    end
  end

  def self.down
    drop_attached_file :parent_categories, :photo
  end
end
