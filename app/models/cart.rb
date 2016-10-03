class Cart < ApplicationRecord
  belongs_to :from_location, class_name: "Location"
  belongs_to :to_location, class_name: "Location"
  has_many :cart_items,  dependent: :destroy
  accepts_nested_attributes_for :cart_items, allow_destroy: true
  #after_save   :validate_cart
  #before_update :validate_cart

  attr_accessor :search_item

  private



  	# Currently not working as expected
    def validate_cart
      puts "Cart content: " + params[:cart][:cart_items_attributes].to_s

      ci = params[:cart][:cart_items_attributes]


      puts "listing values ....."
      ci.values.each do |key, value|
        puts key.to_s + ": " + value.to_s
      end
    
    	if self.from_location.location_type == "Physical"
        puts " Physical location - checking inventories" 
        puts "Number of items in cart: " + cart_items.count.to_s  
        cart_items.each  do  |c|
          #puts "item name: " + c.item_name 
          puts "Processing item id: " + c.item_id.to_s 

          if cart_item.arrival_date == nil
              @inv = Inventory.where("location_id = ? and item_id = ?", cart_item.cart.from_location.id, cart_item.item.id)
          else 
              @inv = Inventory.where("location_id = ? and item_id = ? and arrival_date = ?", cart_item.cart.from_location.id, cart_item.item.id, cart_item.arrival_date)
          end 
          puts "Number of records found: " + @inv.count.to_s
          if  @inv.count > 0
               if @inv.first.qty < cart_item.qty 
                  errors.add(:cart, "Inventory to small")
                  puts "Inventory too small"
                  #cart_item.item = nil
               end
          else
            errors.add(:cart, "Inventory not found")
            puts "Inventory not found"
            #cart_item.item = nil
          end
        end                  
      end     
      puts " Debug validate cart"
  	end
  
end
