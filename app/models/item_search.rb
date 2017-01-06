class ItemSearch < ApplicationRecord

	acts_as_tenant(:account)

	def items
		@items ||= find_items
	end


private

  def find_items
    items = Item.where(item_type_id: item_type_id) if item_type_id.present?
    items
  end

end
