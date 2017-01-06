json.id transaction_type.id.to_s
json.name transaction_type.name
json.from_location transaction_type.from_location.name
json.to_location transaction_type.to_location.name
json.created_at transaction_type.created_at
json.updates_at transaction_type.updated_at
json.url transaction_type_url(transaction_type, format: :html)



