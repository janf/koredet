class ItemField < ApplicationRecord

	acts_as_tenant(:account)

  	belongs_to :item_type, optional: true
  	
end
