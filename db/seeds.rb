# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

seed_data = YAML.load_file('db/seeds.yaml')

seed_data['ParentCategories'].each do |parent_category|
  pc = ParentCategory.find_or_initialize_by name: parent_category['name']
  pc.display_order = parent_category['display_order']
  # pc.slug = parent_category['name'].gsub(/[^a-zA-Z\s]/m, '').gsub(/[\s]+/, '-').downcase
  pc.slug = nil
  pc.save
end

seed_data['Categories'].each do |category|
  c = Category.find_or_initialize_by name: category['name']
  c.display_order = category['display_order']
  c.parent_category_id = ParentCategory.find_by(name: category['parent_category_name']).id
  c.save
end

seed_data['Items'].each do |item|
  i = Item.find_or_initialize_by name: item['name']
  i.display_order = item['display_order']
  i.description = item['description']
  i.category_id = Category.where("name ILIKE ?", item['category_name']).first.id
  i.photo = File.open("/Users/fredwillmore/Desktop/outsideup_photos/#{item['name'].gsub(/[^a-zA-Z\s\/]/m, '').gsub(/[\s\/]+/, '-').downcase}.jpg") rescue nil
  i.save
end
