class CartsController < ApplicationController
  before_action :set_cart, only: [:show, :edit, :update, :destroy]

  # GET /carts
  # GET /carts.json
  def index
    @carts = Cart.all
  end

  # GET /carts/1
  # GET /carts/1.json
  def show
  end

  # GET /carts/new
  def new
    @transaction_type = TransactionType.find_by_id(params[:transaction_type_id])
    @cart = Cart.new
    @cart.from_location_id = @transaction_type.from_location_id
    @cart.to_location_id = @transaction_type.to_location_id
    @cart.process_status = "draft"
  end

  # GET /carts/1/edit
  def edit
  end

  # POST /carts
  # POST /carts.json
  def create
    @cart = Cart.new(cart_params)

    respond_to do |format|
      if @cart.save
        format.html { redirect_to @cart, notice: 'Cart was successfully created.' }
        format.json { render :show, status: :created, location: @cart }
      else
        format.html { render :new }
        format.json { render json: @cart.errors, status: :unprocessable_entity }
      end
    end
  end

  #Processes transactions in cart
  def process_cart
    @cart = Cart.find_by_id(params[:id])

    #Carts.Transaction do
    @cart.cart_items.each do |ci| 
      update_inventory(@cart.from_location_id, ci.item_id, -ci.qty)
      update_inventory(@cart.to_location_id, ci.item_id, ci.qty)
    end  

    @cart.process_status = "processed"
    @cart.save

    render 'show'

  end 

  # PATCH/PUT /carts/1
  # PATCH/PUT /carts/1.json
  def update
    respond_to do |format|
      if @cart.update(cart_params)
        format.html { redirect_to @cart, notice: 'Cart was successfully updated.' }
        format.json { render :show, status: :ok, location: @cart }
      else
        format.html { render :edit }
        format.json { render json: @cart.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /carts/1
  # DELETE /carts/1.json
  def destroy
    @cart.destroy
    respond_to do |format|
      format.html { redirect_to carts_url, notice: 'Cart was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cart
      @cart = Cart.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def cart_params
      params.require(:cart).permit!
    end


    # Helper method for processing_cart, should be moved to inventory model ?
    def update_inventory(location_id, item_id, qty)
        logger.debug "location_id: #{location_id}, item_id: #{item_id}"
        @inventory = Inventory.find_or_initialize_by(location_id: location_id, item_id: item_id)
        @inventory.location_id = location_id
        @inventory.item_id = item_id
        if @inventory.qty.nil?
          @inventory.qty = qty
        else
          @inventory.qty = @inventory.qty + qty
        end  
        @inventory.save
    end 
end