class CartItem < ApplicationRecord
  belongs_to :cart
  belongs_to :item

  

  before_validation  :default_qty
  before_save        :check_inventory
  before_save        :default_arrival_date 
  #before_save        :check_new_item
  


  validates :item_name, presence: true
  #validate :save_object?
    

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
  	if !self.item and name != ""
  		newitem = Item.new
  		newitem.name = name
  		newitem.item_type_id = -1
  		newitem.save
  		self.item = newitem
      item_id = item.id
  	end	
  end

  private 
    def default_qty
      self.qty ||= "1"
    end  

    def default_arrival_date
      self.arrival_date ||= Date.today
    end  

    def check_inventory
      self.status_code = "O"
      self.status_text = ""
      if cart.from_location.location_type == "Physical" then
        inventory = nil
        if !self.arrival_date then
          inventory = Inventory.where("location_id = ? and item_id = ?", cart.from_location.id, item_id).order(arrival_date: :asc)
        else 
          inventory = Inventory.where("location_id = ? and item_id = ? and arrival_date = ?", cart.from_location_id, item_id, arrival_date)
        end    
        inv = inventory.first
        if !inv
          self.status_code = "D"
          self.status_text = "Inventory not found, line will be discarded"
        else
          inv_qty = inv.qty.to_i
          if inv_qty < self.qty.to_i then
            self.status_code = "C"
            self.status_text = "Full inventory not found, qty reduced from " + self.qty.to_s + " to " + inv.qty.to_s
            self.qty = inv.qty
          else
            self.status_code = "O"
            self.status_text = ""
          end  

          self.arrival_date |= inv.arrival_date   
        end 
      end
   
    end    

 
end
