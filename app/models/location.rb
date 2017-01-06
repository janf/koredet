class Location < ApplicationRecord

	acts_as_tenant(:account)

	has_ancestry
	has_many :inventories
	belongs_to :item_type, foreign_key: "default_item_type_id" 


	def self.json_tree(nodes)
    	nodes.map do |node, sub_nodes|
      		{:name => node.name, :id => node.id, :children => Location.json_tree(sub_nodes).compact}
    end
end
	
end
