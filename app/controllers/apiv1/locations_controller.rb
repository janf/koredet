class Apiv1::LocationsController < ApplicationController
  before_action :set_apiv1_location, only: [:show, :edit, :update, :destroy]

  # GET /apiv1/locations
  # GET /apiv1/locations.json
  def index
    @apiv1_locations = Location.all
  end

  # GET /apiv1/locations/1
  # GET /apiv1/locations/1.json
  def show
  end

  # GET /apiv1/locations/new
  def new
    @apiv1_location = Location.new
  end

  # GET /apiv1/locations/1/edit
  def edit
  end

  # POST /apiv1/locations
  # POST /apiv1/locations.json
  def create
    @apiv1_location = Location.new(apiv1_location_params)

    respond_to do |format|
      if @apiv1_location.save
        format.html { redirect_to @apiv1_location, notice: 'Location was successfully created.' }
        format.json { render :show, status: :created, location: @apiv1_location }
      else
        format.html { render :new }
        format.json { render json: @apiv1_location.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /apiv1/locations/1
  # PATCH/PUT /apiv1/locations/1.json
  def update
    respond_to do |format|
      if @apiv1_location.update(apiv1_location_params)
        format.html { redirect_to @apiv1_location, notice: 'Location was successfully updated.' }
        format.json { render :show, status: :ok, location: @apiv1_location }
      else
        format.html { render :edit }
        format.json { render json: @apiv1_location.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /apiv1/locations/1
  # DELETE /apiv1/locations/1.json
  def destroy
    @apiv1_location.destroy
    respond_to do |format|
      format.html { redirect_to apiv1_locations_url, notice: 'Location was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_apiv1_location
      @apiv1_location = Location.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def apiv1_location_params
      params.fetch(:apiv1_location, {})
    end
end
