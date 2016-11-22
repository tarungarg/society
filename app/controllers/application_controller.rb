class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :set_timezone

  helper_method :user_is_president

  helper_method :current_tenant

  def after_sign_in_path_for(resource)
    domain = resource.tenant_domain
    if request.subdomain.blank? || request.subdomain == domain
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
    hash.blank? ? '' : hash.max_by{|k,v| v}[0]
  end

  private

    def set_timezone
      Time.zone = cookies["time_zone"]
    end
end
