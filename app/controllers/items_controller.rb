class ItemsController < ApplicationController
  before_action :authenticate_user!

  autocomplete :item, :name, :full => true

  before_action :set_item, only: [:show, :edit, :update, :destroy]

  # GET /items
  # GET /items.json
  def index
      @items = Item.all
      @item_types = ItemType.all.order(:name)
  end

  # GET /items/1
  # GET /items/1.json
  def show
    @item = Item.includes(:inventories).find(params[:id])
  end

  # GET /items/new
  def new
    puts "Creating new item"
    if params[:item_type_id] 
      @item = Item.new(item_type_id: params[:item_type_id])
    else
      @item = Item.new
    end
  end

  # GET /items/1/edit
  def edit
    @original_item_type_id = params[:item_type_id]
  end

  # POST /items
  # POST /items.json
  def create
    @item = Item.new(item_params)

    respond_to do |format|
      if @item.save
        format.html { redirect_to @item, notice: 'Item was successfully created.' }
        format.json { render json: @item, status: :created }
        format.js { render json: nil, status: :ok }
      else
        format.html { render :new }
        format.json { render json: @item.errors, status: :unprocessable_entity }
        format.js  { render json: nil, status: :ok }
      end
    end
  end

  # PATCH/PUT /items/1
  # PATCH/PUT /items/1.json
  def update
    respond_to do |format|
      if @item.update(item_params)
        format.html { redirect_to @item, notice: 'Item was successfully updated.' }
        format.json { render :show, status: :ok, location: @item }
      else
        format.html { render :edit }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /items/1
  # DELETE /items/1.json
  def destroy
    @item.destroy
    respond_to do |format|
      format.html { redirect_to items_url, notice: 'Item was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_item
      @item = Item.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def item_params
      #params.require(:item).permit(:name, :description, :item_type_id).tap do |whitelisted|
      #    whitelisted[:properties] = params[:item][:properties]
      #end
      params.require(:item).permit(:name, :description, :item_type_id, :properties, :image_url)
    end
end
