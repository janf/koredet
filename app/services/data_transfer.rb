module DataTransfer
	#require 'builder'
	require 'csv'
	
 
	def export_location(location_id)
	
		location = Location.find(location_id)
		inventory = Inventory.where(location_id: location_id).includes(:item)

		csv_string = CSV.generate do |csv|

			csv << ["Location", "Item", "Qty", "Arrival date"] 

	    	inventory.each do |inv|
		    	arr = Array.new
		    	arr[0] = location.name
		    	arr[1] = inv.item.name
		    	arr[2] = inv.qty
		    	arr[3] = inv.arrival_date
		    	csv << arr
		    end
			    
	    end

	    csv_string
	 end

	def export_all_locations
	
		
		inventory = Inventory.includes(:item, :location)

		csv_string = CSV.generate do |csv|

			csv << ["Location", "Item", "Qty", "Arrival date"] 

	    	inventory.each do |inv|
		    	arr = Array.new
		    	arr[0] = inv.location.name
		    	arr[1] = inv.item.name
		    	arr[2] = inv.qty
		    	arr[3] = inv.arrival_date
		    	csv << arr
		    end
			    
	    end

	    csv_string
	 end


	def export_all_xml

  	file = File.new("#{Rails.root}/public/orders-#{Time.now.to_i}.xml", 'w')
 
  	xml = Builder::XmlMarkup.new(target: file, :indent => 4)
  	xml.instruct! :xml, :version=>'1.0'
 
	    @items.each do |i|
	      	xml.!Item do
	 
		        xml.ID i.id
		 	    xml.Name i.name
	 	    end

		end
	end

end