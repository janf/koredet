class InitFirstAccount < ActiveRecord::Migration[5.0]
  	def change

  		account = Account.create(account_name: "FamHavie", account_active: true)

  		User.find_each do |user|
  			user_account = UserAccount.create(user_id: user.id, account_id: account.id)
  			if user.email == "janfredrik@havie.net" 
  				user.global_admin = true
  				user_account.account_admin = true
  			end	
  		end
  			
		tables = ["item_types", "items", "item_fields", "locations", "inventories", "transaction_types", "transactions", "carts", "cart_items" ]
  	 	
  		tables.each do |table_name|
			puts "Updating table: " + table_name + " with account id"
  			results = ActiveRecord::Base.connection.execute("UPDATE  " + table_name + " SET account_id=" + account.id.to_s )		
  		end	
	end
 end
