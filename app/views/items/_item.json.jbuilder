json.extract! item, :id,  :name, :description, :created_at, :updated_at
json.item_type item.item_type.name
json.url item_url(item, format: :html)