require 'will_paginate/array'
class MembersController < BaseController
  load_and_authorize_resource

  before_action :set_member, only: [:edit, :show, :update, :destroy, :update_candidate, :upload_photo]

  # GET /members
  # GET /members.json
  def index
    (@filterrific = initialize_filterrific(
      Member,
      params[:filterrific]
    )) || return
    @members = @filterrific.find.where(tenant_id: current_tenant.id).includes(:roles).page(params[:page])

    banner = Banner.where(area: Banner.areas[:Member]).first
    if banner
      @banner_image = banner.desktop_image.url
      @banner_url = banner.desktop_url
    end
  end

  # GET /members/1
  # GET /members/1.json
  def show
    banner = Banner.where(area: Banner.areas[:MemberShow]).first
    if banner
      @banner_image = banner.desktop_image.url
      @banner_url = banner.desktop_url
    end
  end

  # GET /members/new
  def new
    @member = User.new
  end

  # GET /members/1/edit
  def edit
  end

  # POST /members
  # POST /members.json
  def create
    if check_if_field_empty(member_params)
      respond_to do |format|
        format.html { render :new }
        format.json { render json: @member.errors, status: :unprocessable_entity }
      end
    else
      @member = User.new(member_params)
      @member.tenant_id = current_tenant.id
      respond_to do |format|
        if @member.save
          add_roles(params[:roles])
          format.html { redirect_to member_path(@member), notice: 'Member was successfully created.' }
          format.json { render :show, status: :created, location: @member }
        else
          format.html { render :new }
          format.json { render json: @member.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # PATCH/PUT /members/1
  # PATCH/PUT /members/1.json
  def update
    respond_to do |format|
      if !params[:roles].include?('president') && @member.has_role?(:president) && !Tenant.current.has_presidents
        format.html { redirect_to member_path(@member), notice: 'Please select other user as President.' }
      elsif @member.update(member_params)
        remove_roles
        add_roles(params[:roles])
        format.html { redirect_to member_path(@member), notice: 'Member was successfully updated.' }
        format.json { render :show, status: :ok, location: @member }
      else
        format.html { render :edit }
        format.json { render json: @member.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /members/1
  # DELETE /members/1.json
  def destroy
    if @member.has_role?(:president) && Tenant.current.has_presidents
      destroy_user
    elsif !@member.has_role?(:president)
      destroy_user
    else
      respond_to do |format|
        format.html { redirect_to members_url, notice: 'Please select other user as President.' }
        format.json { head :no_content }
      end
    end
  end

  def emergency_contacts
    @members = User.where(['created_at < ?', 30.days.ago]).order('created_at desc')
    render :index
  end

  def update_candidate
    ElectionsParticipatedUser.add_participations(params[:candidate], @member.id)
    if @member.update(candidate: params[:candidate])
      respond_to do |format|
        format.js
      end
    else
      respond_to do |format|
        format.js { render status: 200, js: "toastr.info('Please Contact Support')" }
      end
    end
  end

  def user_profile
    @post = Post.new
    @posts = Post.paginate(page: params[:page], per_page: 10).order(created_at: 'desc')
  end

  def timeline
    @activities = PublicActivity::Activity.paginate(page: params[:page], per_page: 10).order('created_at desc').where(recipient_id: current_user.id, recipient_type: 'User')
  end

  def profile_update
  end

  def upload_photo
    if @member.update(avatar: params[:avatar])
      respond_to do |format|
        format.js { render status: 200, js: "toastr.info('Upload'); location.reload();" }
      end
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_member
    @member = User.where(id: params[:id], tenant_id: current_tenant.id).first
  rescue Exception
    puts Exception
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def member_params
    # params[:member][:car_nums] = unless params[:member][:car_nums].blank?
    params.require(:member).permit(:name, :flat_no, :tower_no, :mob_num, :email, :alt_no, :blood_group, :occupation, :family_memebers, :adult, :kids, :bio, :password, :password_confirmation, :car_nums, roles: [])
  end

  def add_roles(roles)
    roles.each do |role|
      @member.add_role(role) if User.profile_roles.keys.include?(role)
    end
  end

  def remove_roles
    @member.roles.delete_all
  end

  def destroy_user
    @member.destroy
    remove_roles
    respond_to do |format|
      format.html { redirect_to members_url, notice: 'Member was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def check_if_field_empty(params)
    params[:name] == '' || params[:flat_no] == '' || params[:tower_no] == '' || params[:mob_num] == ''
  end
end
