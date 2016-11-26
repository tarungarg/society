class RoleRouteConstraint
  def initialize
    @block = block || ->(_user) { true }
  end

  def matches?(request)
    request.subdomain.present? && !FORBIDDEN_SUBDOMAINS.include?(request.subdomain) && request.subdomain == 'me'
    user.present? && @block.call(user)
  end

  def current_user(request)
    User.find_by_id(request.session[:user_id]).includes(:user_setting)
  end
end
