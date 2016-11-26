class FundsController < BaseController
  before_action :set_fund, only: [:show, :edit, :update, :destroy]

  # GET /funds
  # GET /funds.json
  def index
    (@filterrific = initialize_filterrific(
      Fund,
      params[:filterrific]
    )) || return
    @funds = @filterrific.find.page(params[:page])
  end

  # GET /funds/1
  # GET /funds/1.json
  def show
  end

  # GET /funds/new
  def new
    @fund = Fund.new
  end

  # GET /funds/1/edit
  def edit
  end

  # POST /funds
  # POST /funds.json
  def create
    @fund = Fund.new(fund_params)

    respond_to do |format|
      if @fund.save
        format.html { redirect_to @fund, notice: 'Fund was successfully created.' }
        format.json { render :show, status: :created, location: @fund }
      else
        format.html { render :new }
        format.json { render json: @fund.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /funds/1
  # PATCH/PUT /funds/1.json
  def update
    respond_to do |format|
      if @fund.update(fund_params)
        format.html { redirect_to @fund, notice: 'Fund was successfully updated.' }
        format.json { render :show, status: :ok, location: @fund }
      else
        format.html { render :edit }
        format.json { render json: @fund.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /funds/1
  # DELETE /funds/1.json
  def destroy
    @fund.destroy
    respond_to do |format|
      format.html { redirect_to funds_url, notice: 'Fund was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_fund
    @fund = Fund.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def fund_params
    params.require(:fund).permit(:amount, :title, :desc, :date)
  end
end
