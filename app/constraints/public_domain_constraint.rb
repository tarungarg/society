class PublicDomainConstraint
  def self.matches?(request)
    !request.subdomain.present?
  end
end
