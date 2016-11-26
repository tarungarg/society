class ElectionsParticipatedUsersController < ApplicationController
  before_action :set_elections_participated_user, only: [:show, :edit, :update, :destroy]

  # GET /elections_participated_users
  # GET /elections_participated_users.json
  def index
    @elections_participated_users = ElectionsParticipatedUser.all
  end

  # GET /elections_participated_users/1
  # GET /elections_participated_users/1.json
  def show
  end

  # GET /elections_participated_users/new
  def new
    @elections_participated_user = ElectionsParticipatedUser.new
  end

  # GET /elections_participated_users/1/edit
  def edit
  end

  # POST /elections_participated_users
  # POST /elections_participated_users.json
  def create
    @elections_participated_user = ElectionsParticipatedUser.new(elections_participated_user_params)

    respond_to do |format|
      if @elections_participated_user.save
        format.html { redirect_to @elections_participated_user, notice: 'Elections participated user was successfully created.' }
        format.json { render :show, status: :created, location: @elections_participated_user }
      else
        format.html { render :new }
        format.json { render json: @elections_participated_user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /elections_participated_users/1
  # PATCH/PUT /elections_participated_users/1.json
  def update
    respond_to do |format|
      if @elections_participated_user.update(elections_participated_user_params)
        format.html { redirect_to @elections_participated_user, notice: 'Elections participated user was successfully updated.' }
        format.json { render :show, status: :ok, location: @elections_participated_user }
      else
        format.html { render :edit }
        format.json { render json: @elections_participated_user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /elections_participated_users/1
  # DELETE /elections_participated_users/1.json
  def destroy
    @elections_participated_user.destroy
    respond_to do |format|
      format.html { redirect_to elections_participated_users_url, notice: 'Elections participated user was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_elections_participated_user
    @elections_participated_user = ElectionsParticipatedUser.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def elections_participated_user_params
    params.require(:elections_participated_user).permit(:user_id, :electon_id)
  end
end
