class ItemType < ApplicationRecord
 	
 	acts_as_tenant(:account)

	has_many :fields, class_name: "ItemField", dependent: :destroy
	has_many :items
	has_many :locations, dependent: :nullify, foreign_key: :default_item_type_id
	accepts_nested_attributes_for :fields, allow_destroy: true
end
