json.array!(@developments) do |development|
  json.extract! development, :id, :title, :info, :description, :status, :development_type, :stage, :delivery_month, :delivery_year, :zone_id, :address, :zip_code, :lat, :lng, :slug
  json.url development_url(development, format: :json)
end
