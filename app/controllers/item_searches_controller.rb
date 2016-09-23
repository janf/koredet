class ItemSearchesController < ApplicationController

	def new
    	@item_search = ItemSearch.new
  	end

	def create
		@item_search = ItemSearch.create!(item_search_params)
		redirect_to @item_search
	end
	  
	def show
	    @item_search = ItemSearch.find(params[:id])
	end

	private

		def item_search_params
			params.require(:item_search).permit(:item_type_id)
		end	

end
