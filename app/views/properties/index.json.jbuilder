json.array!(@properties) do |property|
  json.extract! property, :id, :title, :description, :status, :property_type_id, :age, :environments, :garages, :bathrooms, :toilettes, :sale_price, :sale_currency, :rent_price, :rent_currency, :area_unit, :constructed_area, :unconstructed_area, :zone_id, :address, :zip_code, :lat, :lng, :slug
  json.url property_url(property, format: :json)
end
