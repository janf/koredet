class Transaction < ApplicationRecord
  belongs_to :from_location, class_name: :location
  belongs_to :to_location, class_name: :location
  belongs_to :item
end
