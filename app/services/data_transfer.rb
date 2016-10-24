class Datatransfer
	require 'builder'
	

	def export_data
	
	@items = Items.all.limit(5)
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