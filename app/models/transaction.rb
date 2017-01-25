class Transaction < ApplicationRecord

 	acts_as_tenant(:account)

	belongs_to :from_location, class_name: :location
	belongs_to :to_location, class_name: :location
	belongs_to :item, foreign_key: "items_id"

	attr_accessor :item_name, :item_type

end
