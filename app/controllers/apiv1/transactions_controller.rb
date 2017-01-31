class Apiv1::TransactionsController < ApplicationController
  before_action :set_transaction, only: [:show, :edit, :update, :destroy]

  # GET /apiv1/transactions
  # GET /apiv1/transactions.json
  def index
    @transactions = Transaction.all.order(:name)
  end

  # GET /apiv1/transactions/1
  # GET /apiv1/transactions/1.json
  def show
    respond_to do |format|
      format.html { redirect_to @transaction, notice: 'Transaction was successfully created.' }
      format.json { render :show, status: :created, transaction: @transaction}
    end
  end

  # GET /apiv1/transactions/new
  def new
    @transaction = Transaction.new
  end

  # GET /apiv1/transactions/1/edit
  def edit

  end

  # POST /apiv1/transactions
  # POST /apiv1/transactions.json
  def create
    
    puts "Create Params: " + transaction_params.to_yaml

    if !transaction_params[:items_id].present? then

      puts "Checking item: " + transaction_params[:item_name]

      item = Item.where(name: transaction_params[:item_name]).take

      if !item.present? then
        item = Item.new
        item.name = transaction_params[:item_name]
        item.item_type_id  = transaction_params[:item_type_id]
        item.save
      end
    end


    transaction_params_new = transaction_params.except(:item_name, :item_type_id)
    @transaction = Transaction.new(transaction_params_new)

    @transaction.items_id = item.id

    respond_to do |format|
      if @transaction.save
        format.html { redirect_to @transaction, notice: 'Transaction was successfully created.' }
        format.json { render :show, status: :created, transaction: @transaction}
      else
        format.html { render :new }
        format.json { render json: @transaction.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /apiv1/transactions/1
  # PATCH/PUT /apiv1/transactions/1.json
  def update
    puts "Params: " + transaction_params.to_yaml
  

    if transaction_params[:item_name].present? then  
      #see if item with name exists
      @item = Item.where("lower(name) = ?", transaction_params[:item_name].downcase).first

      check_for_delete_item = false

      if !@item.present? then 
        #No existing item with the changed name, update item name
        @item = Item.find(@transaction.items_id)
        @item.name = transaction_params[:item_name]
        @item.save
      else
        check_for_delete_item = true
      end
    end  

    @transaction = Transaction.find(params[:id])
    transaction_params_new = transaction_params.except(:item_name, :item_type_id)

    old_item_id = @transaction.items_id

    if @item.present? then
      #existing item found, change item id
      transaction_params_new[:items_id] = @item.id
    end

    respond_to do |format|
      if @transaction.update(transaction_params_new)

        #delete old item if not used in transactions 
        if check_for_delete_item then
          item_in_use = Transaction.where(items_id: old_item_id).exists?
          if !item_in_use then
            Item.destroy(old_item_id)
          end
        end

    #    format.html { redirect_to @transaction, notice: 'Transaction was successfully updated.' }
        format.json { render :show, status: :ok, transaction: @transaction }
    #  else
    #    format.html { render :edit }
    #    format.json { render json: @transaction.errors, status: :unprocessable_entity }
      end
    end
    #format.json { render :params, status: :ok, transaction: @transaction }
  end

  # DELETE /apiv1/transactions/1
  # DELETE /apiv1/transactions/1.json
  def destroy
    @transaction.destroy
    respond_to do |format|
      format.html { redirect_to transactions_url, notice: 'Transaction was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_transaction
      @transaction = Transaction.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def transaction_params
        params.require(:transaction).permit(:id, :items_id, :item_name, :item_type_id, :qty)
    end
end
