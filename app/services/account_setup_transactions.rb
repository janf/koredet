class AccountSetupTransactionTypes

	# Starting with basic type aded programmatically
	# Could later be replaced by a more configurable, data-driven appoach

	def add_transactions(account)
		transactions = Transaction.where(account_id: account.id)
		if transactions.count == 0 

			locations = Locaction.where(account_id: account.id, location_type: "Physical")

			loc_in = Location.where(name: "Items In").first
			if !loc_in.present?
				loc_in = add_location("Items in", "Flow")
			end

			loc_out = Location.where(name: "Items Out").first
			if !loc_out.present?
				loc_out = add_location("Items out", "Flow")
			end

			locations.each do |loc|
				add_transaction(loc_in, loc)
				add_transaction(loc, loc_out)
			end

			
		end
	end	


	private 

		def add_transaction(loc_from, loc_to)
			trans = Transaction.new


		#Helper methods borrowed from AccountSetupLocations, should be DRYed up

		def add_location(name, location_type, parent_name=nil, default_item_type_name=nil)
			loc = Location.new
			loc.name = name
			loc.location_type = location_type
			
			if parent_name.present?
				loc.parent_id = find_location_id(parent_name)
			end
			
			if 	default_item_type_name.present?
				loc.default_item_type_id = find_item_type_id(default_item_type_name)
			end

			loc.save
		end	

		def find_location_id(location_name)
			loc = Location.where(name: location_name).first
			puts "find_location_id(location_name), found" + loc.name
			loc.id
		end	

		def find_item_type_id(item_name)
			it = ItemType.where(name: item_name).first
			it.id
		end	



end