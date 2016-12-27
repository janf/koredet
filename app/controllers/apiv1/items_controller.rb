class Apiv1::ItemsController < ApplicationController
  before_action :set_apiv1_item, only: [:show, :edit, :update, :destroy]

  # GET /apiv1/items
  # GET /apiv1/items.json
  def index
    @apiv1_items = Item.all
  end

  # GET /apiv1/items/1
  # GET /apiv1/items/1.json
  def show
  end

  # GET /apiv1/items/new
  def new
    @apiv1_item = Item.new
  end

  # GET /apiv1/items/1/edit
  def edit
  end

  # POST /apiv1/items
  # POST /apiv1/items.json
  def create
    @apiv1_item = Item.new(apiv1_item_params)

    respond_to do |format|
      if @apiv1_item.save
        format.html { redirect_to @apiv1_item, notice: 'Item was successfully created.' }
        format.json { render :show, status: :created, location: @apiv1_item }
      else
        format.html { render :new }
        format.json { render json: @apiv1_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /apiv1/items/1
  # PATCH/PUT /apiv1/items/1.json
  def update
    respond_to do |format|
      if @apiv1_item.update(apiv1_item_params)
        format.html { redirect_to @apiv1_item, notice: 'Item was successfully updated.' }
        format.json { render :show, status: :ok, location: @apiv1_item }
      else
        format.html { render :edit }
        format.json { render json: @apiv1_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /apiv1/items/1
  # DELETE /apiv1/items/1.json
  def destroy
    @apiv1_item.destroy
    respond_to do |format|
      format.html { redirect_to apiv1_items_url, notice: 'Item was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_apiv1_item
      @apiv1_item = Item.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def apiv1_item_params
      params.fetch(:apiv1_item, {})
    end
end
