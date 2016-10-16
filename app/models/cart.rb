class Cart < ApplicationRecord

  acts_as_tenant(:account)

  belongs_to :from_location, class_name: "Location"
  belongs_to :to_location, class_name: "Location"
  has_many :cart_items,  dependent: :destroy
  accepts_nested_attributes_for :cart_items, allow_destroy: true,  reject_if: :item_name_missing? 
  #after_save   :validate_cart
  #before_update :validate_cart

  attr_accessor :search_item

  private

    def item_name_missing?(att)
      att['item_name'].blank? && new_record?
    end 

end
