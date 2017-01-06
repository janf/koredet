class TransactionType < ApplicationRecord

	acts_as_tenant(:account)

 	belongs_to :from_location, class_name: "Location" 
  	belongs_to :to_location, class_name: "Location"
end
