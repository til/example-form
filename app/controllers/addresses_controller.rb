class AddressesController < ApplicationController
  before_action :set_address, only: %i[ show edit update destroy ]

  # GET /addresses or /addresses.json
  def index
    @addresses = Address.all
  end

  # GET /addresses/1 or /addresses/1.json
  def show
  end

  # GET /addresses/new
  def new
    @address = Address.new
  end

  # GET /addresses/1/edit
  def edit
  end

  # POST /addresses
  def create
    @address = Address.new(address_params)

    if params[:refresh_form]
      render :new
    else
      if @address.save
        redirect_to @address, notice: "Address was successfully created."
      else
        render :new, status: :unprocessable_entity
      end
    end
  end

  # PATCH/PUT /addresses/1 or /addresses/1.json
  def update
    respond_to do |format|
      if @address.update(address_params)
        format.html { redirect_to @address, notice: "Address was successfully updated." }
        format.json { render :show, status: :ok, location: @address }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @address.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /addresses/1 or /addresses/1.json
  def destroy
    @address.destroy!

    respond_to do |format|
      format.html { redirect_to addresses_path, status: :see_other, notice: "Address was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_address
      @address = Address.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def address_params
      params.expect(address: [ :country, :state, :city ])
    end
end
