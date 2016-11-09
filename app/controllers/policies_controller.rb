class PoliciesController < BaseController
  before_action :set_policy, only: [:show, :edit, :update, :destroy, :download]
  before_action :check_user_is_president, only: [:create, :update, :destroy]

  # GET /policies
  # GET /policies.json
  def index
    @policies = Policy.all
    @unread_policy_ids = Policy.unread_by(current_user).map(&:id)
  end

  # GET /policies/1
  # GET /policies/1.json
  def show
    @policy.mark_as_read! :for => current_user
    @unread_policy_ids = Policy.unread_by(current_user).map(&:id)
  end

  # GET /policies/new
  def new
    @policy = Policy.new
  end

  # GET /policies/1/edit
  def edit
  end

  # POST /policies
  # POST /policies.json
  def create
    @policy = current_user.policies.new(policy_params)

    respond_to do |format|
      if @policy.save
        format.html { redirect_to @policy, notice: 'Policy was successfully created.' }
        format.json { render :show, status: :created, location: @policy }
      else
        format.html { render :new }
        format.json { render json: @policy.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /policies/1
  # PATCH/PUT /policies/1.json
  def update
    respond_to do |format|
      if @policy.update(policy_params)
        format.html { redirect_to @policy, notice: 'Policy was successfully updated.' }
        format.json { render :show, status: :ok, location: @policy }
      else
        format.html { render :edit }
        format.json { render json: @policy.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /policies/1
  # DELETE /policies/1.json
  def destroy
    @policy.destroy
    respond_to do |format|
      format.html { redirect_to policies_url, notice: 'Policy was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def download
    file = @policy.file.path
    extension = @policy.file.file.extension.downcase
    disposition = 'attachment'
    mime = MIME::Types.type_for(file).first.content_type

    if %w{jpg png jpg gif bmp}.include?(extension) or extension == "pdf"
      disposition = 'inline'
    end
    send_file file, :type => mime, :disposition => disposition
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_policy
      @policy = Policy.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def policy_params
      params.require(:policy).permit(:name, :file, :body, :user_id)
    end

    def check_user_is_president
      unless user_is_president
        raise "You are not authorized"
      end
    end
end
