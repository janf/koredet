class Cartverification


  def verify(cart_params)
    puts "Cartverification#verify"	
    puts "Cart content: " + cart_params.to_yaml
    
    # Set up processing of cart

    ci = cart_params[:cart_items_attributes]
    from_location_id = cart_params[:from_location_id] 
    from_location = Location.find(:from_location_id)
    
    #puts from_location.location_type

    check_inventory = false

    if from_location.location_type == "Physical"
      puts "Physical location - will check against inventory"
      check_inventory = true
    end   


    # Process each line


    #puts "Listing lines"

    #puts "listing cart_items_attributes (cart lines)"

    #ci.each do |key, value|
    #  puts "Key : " + key.to_s + " Value: " + value.to_json
    #end  

    
    ci.values.each do |line|
      #line.each do |key, value|
      #  puts "Key: " + key.to_s + " Value: " + value.to_s
      #end


      # eliminate blank lines
      if line[:item_name] == "" then
        line[:_destroy] = "true"
        puts "Destroy empty item"
        next
      end    

      # Set process status
      line[:status_code] = "O"

      #See if new items were created
      item_found = true   
      
      item = Item.find_by(name: line[:item_name])
      
      if item.nil? then
        item_found = false
        puts "New item - not saved" 
        line[:status_code] = 'C'
        line[:status_text] = 'Item will be created'
      else if item.item_type_id == nil
          puts "New item: " + item.name
          line[:status_code] = 'C'
          line[:status_text] = 'Item will be created'
        else
          puts "Existing item: " + item.name
        end  
      end    
      
      if check_inventory and item_found then
        #find item id for lookup in inventory
        item = Item.where(name: line[:item_name]).first 
        item_id = item.id 
        puts "Looked up item" + line[:item_name].to_s + ", found id " + item_id.to_s
        
        cart_line_qty = [1, line[:qty].to_i].max
        inventory = nil
        #if date is unspecified then lookup all items
        arrival_date = line[:arrival_date]
        if arrival_date.nil? then
          arrival_date = ""
        end  
        if arrival_date == "" then
          puts "No date specified, will use oldest inventory"
          inventory = Inventory.where("location_id = ? and item_id = ?", from_location_id, item_id).order(arrival_date: :asc)
          inv = inventory.first
          #puts inv.to_yaml
          if inv.nil? then
            puts "No inventory found"
            line[:qty] = cart_line_qty.to_s
            line[:status_code] = 'D'
            line[:status_text] = 'No inventory found, this line will be discarded'
          else
            inv_qty = inv.qty.to_i
            puts "Asked for " + cart_line_qty.to_s +   ", found  " + inv.qty.to_i.to_s + " items at arrival_date " + inv.arrival_date.to_s
            line[:arrival_date] = inv.arrival_date
            puts "Setting arrival_date to " + line[:arrival_date].to_s
 
            # Chech for availability at date
            if inv_qty < line[:qty].to_i then
              line[:status_code] = 'C'
              line[:status_text] = 'Full inventory not found, qty reduced from ' + line[:qty].to_s + " to " + inv.qty.to_s
              line[:qty] = inv.qty
            end   
          end        
        else  
          puts "Arrival date: " + arrival_date 
          inventory = Inventory.where("location_id = ? and item_id = ? and arrival_date = ?", from_location_id, item_id, arrival_date)
          inv = inventory.first
          if inv.nil? then
            puts "No inventory found"
            line[:status_code] = 'D'
            line[:status_text] = 'No inventory found, this line will be discarded'
          else
            inv_qty = inv.qty.to_i
            if inv_qty < line[:qty].to_i then
              line[:status_code] = 'C'
              line[:status_text] = 'Full inventory not found, qty reduced from ' + line[:qty] + " to " + inventory.qty
              line[:qty] = inventory.qty
            end   
          end        
        end
      end
    end
    puts "Cart content after update: " + cart_params[:cart_items_attributes].to_yaml
    puts "***Returning from Cartverification#verify"
    cart_params
  end  
  

end
