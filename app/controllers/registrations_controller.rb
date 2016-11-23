class RegistrationsController < Devise::RegistrationsController
  skip_before_filter :require_no_authentication, only: [:new, :create]
  before_filter :check_if_me,  only: [:new, :create]

  def new
    build_resource({})
    yield resource if block_given?
    respond_with resource
  end

  # POST /resource
  def create
    build_resource(sign_up_params)

    resource.save
    yield resource if block_given?

    if resource.persisted?
      sign_out current_user
      if resource.active_for_authentication?
        set_flash_message! :notice, :signed_up
        sign_up(resource_name, resource)
        respond_with resource, location: after_sign_up_path_for(resource)
      else
        set_flash_message! :notice, :"signed_up_but_#{resource.inactive_message}"
        expire_data_after_sign_in!
        respond_with resource, location: after_inactive_sign_up_path_for(resource)
      end
    else
      clean_up_passwords resource
      set_minimum_password_length
      respond_with resource
    end
  end

  private

    def sign_up_params
      params.require(:user).permit(:email, :password, :subdomain,
                                   society_profile_attributes:
                                         [:society_name, :mobile_number, :street_addr, :city, :state, :zip],
                                    tenant_attributes:
                                          [:domain]
                                  )
    end

  def after_sign_up_path_for(resource)
    root_url
  end

  def check_if_me
    unless current_user && current_user.has_role?(:me)
      respond_to do |format|
        format.html { redirect_to root_url, notice: "You are not authorized to access this page" }
        format.js { render js: "location.href = '/';toastr.error('Not authorized');" }
      end
    end
  end

end
