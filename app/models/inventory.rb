class Inventory < ApplicationRecord
  belongs_to :location
  belongs_to :item
end
