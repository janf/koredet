class CartItem < ApplicationRecord
  belongs_to :cart
  belongs_to :item


  def item_name
  	item.try(:name)
  end

  def category_name=(name)
  	self.item = Item.find_or_create_by(name: name) if name.present?
  end

end
