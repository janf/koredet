class CartItem < ApplicationRecord
  belongs_to :cart
  belongs_to :item

  before_create  :default_values

  def arrival_date_locfmt
    arrival_date
  end
  
  def arrival_date_locfmt=(adate)
    self.arrival_date = adate
  end  

  def item_name
  	item.try(:name)
  end

  def get_item_id
    item_id
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

  private 
    def default_values
      if self.qty == nil
         self.qty = 1
      end
      if self.arrival_date == nil   
        self.arrival_date = Date.today
      end   
    end  

end
