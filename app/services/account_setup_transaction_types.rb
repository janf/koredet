class AccountSetupTransactionTypes

	# Starting with basic type aded programmatically
	# Could later be replaced by a more configurable, data-driven appoach

	def add_transaction_types(account)
		transactions = Transaction.where(account_id: account.id)
		if transactions.count == 0 

			

			loc_in = Location.where(name: "Items in").first
			#if !loc_in.present?
			#	loc_in = add_location("Items in", "Flow")
			#end

			loc_out = Location.where(name: "Items out").first
			#if !loc_out.present?
			#	loc_out = add_location("Items out", "Flow")
			#end

			locations = Location.where(account_id: account.id, location_type: "Physical")

			# puts "Location count" + locations.count.to_s

			locations.each do |loc|
				if !(loc.default_item_type_id == nil)
					add_transaction_type(loc_in, loc, "Put new items in " + loc.name)
					add_transaction_type(loc, loc_out, "Use items from " + loc.name)
				end
			end

			
		end
	end	


	private 

		def add_transaction_type(loc_from, loc_to, name)
			tt = TransactionType.new
			tt.from_location_id = loc_from.id
			tt.to_location_id = loc_to.id
			tt.name = name
			tt.description = "Auto-generated transation type"
			tt.save
		end	


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
			# puts "find_location_id(location_name), found" + loc.name
			loc.id
		end	

		def find_item_type_id(item_name)
			it = ItemType.where(name: item_name).first
			it.id
		end	



end