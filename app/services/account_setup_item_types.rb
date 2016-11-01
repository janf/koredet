class AccountSetupItemTypes

	# Starting with basic type aded programmatically
	# Could later be replaced by a more configurable, data-driven appoach

	def add_item_types(account)
		puts "AccountSetupItemTypes-add_item_types(account)"
		item_types = ItemType.where(account_id: account.id)
		if item_types.count == 0 
			add_item_type_food
			add_item_type_drink
			add_item_type_tool
			add_item_type_valueable
		end
	end	

	def add_item_type_food
		it = create_item_type("Food")
		add_field(it,"Weight", "text_field", false)
		add_field(it,"Durability", "text_field", false)
		add_field(it,"ProductBarcode", "text_field", false)
	end

	def add_item_type_drink
		it = create_item_type("Drink")
		add_field(it,"Type", "text_field", false)
	end

	def add_item_type_tool
		it = create_item_type("Tool")
		add_field(it,"Brand", "text_field", false)
		add_field(it,"Value", "text_field", false)
	end


	def add_item_type_valueable
		it = create_item_type("Valuable")
		add_field(it,"Value", "text_field", false)
	end


	private 

		def create_item_type(name)
			it = ItemType.new
			it.name = name
			it.save
			it
		end	
		
		def add_field(it, name, type, required)
			field = it.fields.new
			field.name = name
			field.field_type = type
			field.required = required
			field.save
		end


end