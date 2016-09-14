class CartItem < ApplicationRecord
  belongs_to :cart
  belongs_to :item


  def item_name
  	item.try(:name)
  end

  def item_name=(name)
  	self.item = Item.find_by(name: name) if name.present?
  	if !self.item
		newitem = Item.new
		newitem.name = name
		newitem.item_type_id = 1
		newitem.save
		self.item = newitem
	end	
  end

end
