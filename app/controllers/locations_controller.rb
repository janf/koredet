require 'will_paginate/array'
include DataTransfer

class LocationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_location, only: [:show, :edit, :update, :destroy]

  # GET /locations
  # GET /locations.json
  def index
    @locations = Location.all.order(:name).paginate(:page => params[:page])
    #@locations = Location.roots
  end

  # GET /locations/1
  # GET /locations/1.json
  def show
  
    @id = params[:id]
    #@location = Location.find(params[:id])
    @inventory = Inventory.find_by_sql(['select inventories.*, items.name 
                                        from inventories, items 
                                        where (inventories.item_id = items.id) 
                                        and (inventories.location_id = ?) 
                                        order by items.name', @id ]).paginate(:page => params[:page])

    respond_to do |format|
      format.html
      format.csv { send_data export_location(params[:id]), filename: "Items_at_"+ @location.name.gsub(/\s+/, "") + ".csv"  }
      #format.xls { send_data @products.to_csv(col_sep: "\t") }
    end
  end

  # GET /locations/new
  def new
    @location = Location.new(:parent_id => params[:parent_id])
  end

  # GET /locations/1/edit
  def edit
  end

  # POST /locations
  # POST /locations.json
  def create
    @location = Location.new(location_params)

    respond_to do |format|
      if @location.save
        format.html { redirect_to @location, notice: 'Location was successfully created.' }
        format.json { render :show, status: :created, location: @location }
      else
        format.html { render :new }
        format.json { render json: @location.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /locations/1
  # PATCH/PUT /locations/1.json
  def update
    respond_to do |format|
      if @location.update(location_params)
        format.html { redirect_to @location, notice: 'Location was successfully updated.' }
        format.json { render :show, status: :ok, location: @location }
      else
        format.html { render :edit }
        format.json { render json: @location.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /locations/1
  # DELETE /locations/1.json
  def destroy
    @location.destroy
    respond_to do |format|
      format.html { redirect_to locations_url, notice: 'Location was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_location
      @location = Location.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def location_params
      params.require(:location).permit(:name, :location_type, :parent_id, :default_item_type_id)
    end
end
