class ItemType < ApplicationRecord
 	
 	acts_as_tenant(:account)

	has_many :fields, class_name: "ItemField"
	has_many :items
	has_many :locations, dependent: :nullify
	accepts_nested_attributes_for :fields, allow_destroy: true
end
