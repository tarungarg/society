class ComplaintsController < BaseController
  before_action :set_complaint, only: [:show, :edit, :update, :destroy, :upvote]

  # GET /complaints
  # GET /complaints.json
  def index
    @filterrific = initialize_filterrific(
        Complaint,
        params[:filterrific]
      ) or return
      if params[:public_data]
        @complaints = @filterrific.find.where(view_publically: true).page(params[:page])
      else
        @complaints = @filterrific.find.where(user_id: current_user.id).page(params[:page])
      end
  end

  # GET /complaints/1
  # GET /complaints/1.json
  def show
  end

  # GET /complaints/new
  def new
    @complaint = current_user.complaints.new
  end

  # GET /complaints/1/edit
  def edit
  end

  # POST /complaints
  # POST /complaints.json
  def create
    @complaint = current_user.complaints.new(complaint_params)

    respond_to do |format|
      if @complaint.save
        format.html { redirect_to @complaint, notice: 'Complaint was successfully created.' }
        format.json { render :show, status: :created, location: @complaint }
      else
        format.html { render :new }
        format.json { render json: @complaint.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /complaints/1
  # PATCH/PUT /complaints/1.json
  def update
    respond_to do |format|
      if @complaint.update(complaint_params)
        format.html { redirect_to @complaint, notice: 'Complaint was successfully updated.' }
        format.json { render :show, status: :ok, location: @complaint }
      else
        format.html { render :edit }
        format.json { render json: @complaint.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /complaints/1
  # DELETE /complaints/1.json
  def destroy
    @complaint.destroy
    respond_to do |format|
      format.html { redirect_to complaints_url, notice: 'Complaint was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def upvote
    @complaint.vote_by :voter => current_user unless current_user.voted_for?(@complaint)
    @size = @complaint.get_upvotes.size
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_complaint
      @complaint = Complaint.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def complaint_params
      params.require(:complaint).permit(:title, :desc, :status, :view_publically, :random)
    end
end
