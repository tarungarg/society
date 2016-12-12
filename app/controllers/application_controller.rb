class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :set_timezone, :set_cookie

  helper_method :user_is_president
  helper_method :current_tenant
  helper_method :mailbox, :conversation

  layout :layout_by_resource


  def after_sign_in_path_for(resource)
    domain = resource.tenant_domain
    if domain == 'me'
      # sign_out resource
      new_user_registration_url(subdomain: domain)
    elsif request.subdomain.blank? || request.subdomain == domain
      root_url(subdomain: domain)
    else
      raise "User doen't not belong to this socity. Please contect society president for this"
    end
  end

  def user_is_president
    @user_is_president ||= current_user.has_role? :president
  end

  def current_tenant
    @current_tenant = Tenant.find_by(domain: request.subdomain) unless main_domain?
  end

  def main_domain?
    request.subdomain.blank? || FORBIDDEN_SUBDOMAINS.include?(request.subdomain)
  end

  def largest_hash_key(hash)
    unless hash.blank?
      max = hash.values.max
      Hash[hash.select { |_k, v| v == max }]
    end
  end

  protected

  def layout_by_resource
    if devise_controller? and !user_signed_in?
      'login'
    else
      'application'
    end
  end

  private

  def set_timezone
    Time.zone = cookies['time_zone']
  end

  def mailbox
    @mailbox ||= current_user.mailbox
  end

  def conversation
    @conversation ||= mailbox.conversations.find(params[:id])
  end

  def set_cookie
    cookies.permanent.signed[:user_id] = current_user.id if current_user
  end
end
