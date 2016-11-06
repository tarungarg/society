class SubDomainConstraint
  def self.matches?(request)
    request.subdomain.present? && !FORBIDDEN_SUBDOMAINS.include?(request.subdomain)
  end
end
