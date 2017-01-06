json.extract! cart, :id, :from_location_id, :to_location_id, :created_at, :updated_at
json.url cart_url(cart, format: :json)