json.array!(@showcase_items) do |showcase_item|
  json.extract! showcase_item, :id, :showcaseable_id, :showcaseable_type
  json.url showcase_item_url(showcase_item, format: :json)
end
