class Location < ApplicationRecord
	has_ancestry
	has_many :inventories
	belongs_to :item_type, foreign_key: "default_item_type_id" 
	
end
