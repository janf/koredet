json.extract! inventory, :id, :qty, :location_id, :item_id, :created_at, :updated_at
json.url inventory_url(inventory, format: :json)