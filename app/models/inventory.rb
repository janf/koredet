class Inventory < ApplicationRecord
	
 	acts_as_tenant(:account)

  	belongs_to :location
  	belongs_to :item
end
