class Cart < ApplicationRecord
  belongs_to :from_location, class_name: "Location"
  belongs_to :to_location, class_name: "Location"
  has_many :cart_items
  accepts_nested_attributes_for :cart_items, allow_destroy: true
end
