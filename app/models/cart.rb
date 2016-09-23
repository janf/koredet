class Cart < ApplicationRecord
  belongs_to :from_location, class_name: "Location"
  belongs_to :to_location, class_name: "Location"
  has_many :cart_items
  accepts_nested_attributes_for :cart_items, allow_destroy: true

  before_save   :validate_cart
  before_update :validate_cart

  attr_accessor :search_item

  private

  	# Currently not working as expected
    def validate_cart
    	puts "Cart items: " + self.cart_items.count.to_s
    	if self.cart_items.count == 0
    		errors.add(:carts, "At least one item must be added")
    		false
    	end	
	end
  

end
