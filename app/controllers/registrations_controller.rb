class RegistrationsController < Devise::RegistrationsController


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
    root_url(subdomain: resource.tenant_domain)
  end

end
