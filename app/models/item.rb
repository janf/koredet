class Item < ApplicationRecord

	acts_as_tenant(:account)

	belongs_to :item_type
	has_many :inventories, dependent: :destroy
	has_many :cart_items, dependent: :destroy

	serialize :properties, Hash

	validate :validate_properties

	def self.text_search(query)
  		if query.present?
    		where("name ilike :q or description ilike :q", q: "%#{query}%")
  		else
    		all
  		end
	end

	def validate_properties
		if item_type.present?
			item_type.fields.each do |field|
				if field.required? && properties[field.name].blank?
					errors.add field.name, "must not be blank"
				end
			end
		end
	end			
end
