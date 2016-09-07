class ItemField < ApplicationRecord
  belongs_to :item_type, optional: true
end
