def list_children(json, node)
	# puts node.name + " - "
	if node.ancestry.present?
	 	# puts "Ans: " + node.ancestry
	end
	json.children node.children do |child|
   		json.partial! 'location_tree', loc: child
   		if child.has_children? 
   			list_children(json, child)
   		end
	end   
end

json.array! @locations.each do |root|
	json.partial! 'location_tree', loc: root
	list_children(json, root)
end
#json.extract! @locations  :name 
