json.array!(@items) do |item|
  json.extract! item, :id, :display_order, :name, :description, :category_id
  json.url item_url(item, format: :json)
end
