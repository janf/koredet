class AccountSetupLocations

	# Starting with basic type aded programmatically
	# Could later be replaced by a more configurable, data-driven appoach

	def add_locations(account)
		puts "AccountSetupLocations-add_item_types(account)"
		locations = Location.where(account_id: account.id)
		if locations.count == 0 
			add_location("Items in", "Flow")
			add_location("Items out", "Flow")

			add_location("My home", "Physcical")
			add_location("Freezer", "Physcical", "My home", "Food")
		end
	end	


	private 

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