class AffilatesController < ApplicationController
  before_action :set_affilate, only: [:show, :edit, :update, :destroy]

  # GET /affilates
  # GET /affilates.json
  def index
    @affilates = Affilate.where('name != ?', 'Admin')
  end

  # GET /affilates/1
  # GET /affilates/1.json
  def show
  end

  # GET /affilates/new
  def new
    @affilate = Affilate.new
  end

  # GET /affilates/1/edit
  def edit
  end

  # POST /affilates
  # POST /affilates.json
  def create
    @affilate = Affilate.new(affilate_params)

    respond_to do |format|
      if @affilate.save
        format.html { redirect_to @affilate, notice: 'Affilate was successfully created.' }
        format.json { render :show, status: :created, location: @affilate }
      else
        format.html { render :new }
        format.json { render json: @affilate.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /affilates/1
  # PATCH/PUT /affilates/1.json
  def update
    respond_to do |format|
      if @affilate.update(affilate_params)
        format.html { redirect_to @affilate, notice: 'Affilate was successfully updated.' }
        format.json { render :show, status: :ok, location: @affilate }
      else
        format.html { render :edit }
        format.json { render json: @affilate.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /affilates/1
  # DELETE /affilates/1.json
  def destroy
    @affilate.destroy
    respond_to do |format|
      format.html { redirect_to affilates_url, notice: 'Affilate was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_affilate
      @affilate = Affilate.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def affilate_params
      params.require(:affilate).permit(:address, :name, :phone)
    end
end
