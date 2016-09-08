class DashboardController < ApplicationController
  before_filter :authenticate_user!

  def index
     #@item_type_count = ItemType.count
     #@item_class_count = ItemClass.count
     #@item_count = Item.count
     #@location_type_count = LocationType.count
     #@location_class_count = LocationClass.count
     #@location_count = Location.count
     #@inventory_count = Inventory.count
     @transaction_types = TransactionType.all
  end

end
