json.extract! transaction, :id,  :qty, :created_at, :updated_at
json.item_id transaction.items_id
json.item_name transaction.item.name

json.item_type_id transaction.item.item_type_id



