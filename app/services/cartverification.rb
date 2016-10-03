class Cartverification


def verify(params)
  puts "Cartverification#verify"	
  puts "Cart content: " + params[:cart][:cart_items_attributes].to_yaml
    puts "Cart content: " + params[:cart][:cart_items_attributes].to_s

    ci = params[:cart][:cart_items_attributes]
    from_location_id = params[:cart][:from_location_id] 
    from_location_id = Location.find(from_location_id)

    puts "Listing lines"


    puts "listing cart_items_attributes"
    ci.each do |key, value|
      puts "Key : " + key.to_s + " Value: " + value.to_json
    end  

    puts "listing values ....."
    ci.values.each do |line|
      line.each do |key, value|
        puts "Key: " + key.to_s + " Value: " + value.to_s
      end
      item = Item.where(name: line[:item_name]).first  
      item_id = item.id 
      inventory = Inventory.where("location_id = ? and item_id = ?", from_location_id, item_id).first
      puts "Item id: " + item.id.to_s
    end
end  


end
