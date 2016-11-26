class ChargesController < BaseController
  before_action :set_charge, only: [:show, :edit, :update, :destroy]
  before_action :list_users, only: [:show, :new]

  # GET /charges
  # GET /charges.json
  def index
    @charges = Charge.all
    @charge_ids = current_user.charge_subscriptions.map(&:charge_id)
  end

  # GET /charges/1
  # GET /charges/1.json
  def show
    @subscription_ids = Subscription.all.collect { |k| [k.user_id, k.charge_id] }
    respond_to do |format|
      format.html
      format.js { render :index }
    end
  end

  # GET /charges/new
  def new
    @charge = Charge.new

    respond_to do |format|
      format.html
      format.js { render :index }
    end
  end

  # GET /charges/1/edit
  def edit
  end

  # POST /charges
  # POST /charges.json
  def create
    @charge = Charge.new(charge_params)
    @charge.user_id = current_user.id

    respond_to do |format|
      if @charge.save
        format.html { redirect_to @charge, notice: 'Charge was successfully created.' }
        format.json { render :show, status: :created, location: @charge }
      else
        format.html { render :new }
        format.json { render json: @charge.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /charges/1
  # PATCH/PUT /charges/1.json
  def update
    respond_to do |format|
      if @charge.update(charge_params)
        format.html { redirect_to @charge, notice: 'Charge was successfully updated.' }
        format.json { render :show, status: :ok, location: @charge }
      else
        format.html { render :edit }
        format.json { render json: @charge.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /charges/1
  # DELETE /charges/1.json
  def destroy
    @charge.destroy
    respond_to do |format|
      format.html { redirect_to charges_url, notice: 'Charge was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def invite
    respond_to do |format|
      if Subscription.where(charge_id: params[:charge_id], user_id: params[:user_id]).blank?
        if Subscription.create_subscription(params[:charge_id], params[:user_id])
          format.js
        else
          format.js { render status: 200, js: "toastr.info('Please Contact Support')" }
        end
      else
        format.js { render status: 200, js: "toastr.info('Don't Play)" }
      end
    end
  end

  def invite_all
    User.where(tenant_id: current_tenant.id).each do |user|
      if Subscription.where(charge_id: params[:charge_id], user_id: user.id).blank?
        Subscription.create_subscription(params[:charge_id], user.id)
      end
    end
    respond_to do |format|
      format.js { render status: 200, js: "toastr.info('Success')" }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_charge
    @charge = Charge.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def charge_params
    params[:charge][:period] = params[:charge][:period].to_i
    params.require(:charge).permit(:from_date, :to_date, :period, :amount, :title, :desc)
  end

  def list_users
    if user_is_president
      (@filterrific = initialize_filterrific(
        Member,
        params[:filterrific]
      )) || return
      @members = @filterrific.find.where(tenant_id: current_tenant.id).includes(:roles).page(params[:page])
    end
  end
end
