class CarpoolsController < BaseController
  before_action :set_carpool, only: [:show, :edit, :update, :destroy]

  # GET /carpools
  # GET /carpools.json
  def index
    @carpools = Carpool.all
  end

  # GET /carpools/1
  # GET /carpools/1.json
  def show
  end

  # GET /carpools/new
  def new
    @carpool = Carpool.new
  end

  # GET /carpools/1/edit
  def edit
  end

  # POST /carpools
  # POST /carpools.json
  def create
    @carpool = Carpool.new(carpool_params)

    respond_to do |format|
      if @carpool.save
        format.html { redirect_to @carpool, notice: 'Carpool was successfully created.' }
        format.json { render :show, status: :created, location: @carpool }
      else
        format.html { render :new }
        format.json { render json: @carpool.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /carpools/1
  # PATCH/PUT /carpools/1.json
  def update
    respond_to do |format|
      if @carpool.update(carpool_params)
        format.html { redirect_to @carpool, notice: 'Carpool was successfully updated.' }
        format.json { render :show, status: :ok, location: @carpool }
      else
        format.html { render :edit }
        format.json { render json: @carpool.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /carpools/1
  # DELETE /carpools/1.json
  def destroy
    @carpool.destroy
    respond_to do |format|
      format.html { redirect_to carpools_url, notice: 'Carpool was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_carpool
    @carpool = Carpool.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def carpool_params
    params.require(:carpool).permit(:title, :desc, :user_id, :date, :routes, :tag_list)
  end
end
