json.array!(@parent_categories) do |parent_category|
  json.extract! parent_category, :id, :display_order, :name, :description
  json.url parent_category_url(parent_category, format: :json)
end
