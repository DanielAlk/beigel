json.array!(@promotions) do |promotion|
  json.extract! promotion, :id, :promotionable_id, :promotionable_type
  json.url promotion_url(promotion, format: :json)
end
