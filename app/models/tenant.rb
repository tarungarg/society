class Tenant < ActiveRecord::Base
  has_many :users

  # after_create :add_tenant_to_apartment

  def self.current
    tenant = Tenant.find_by domain:Apartment::Tenant.current
    tenant
  end

  private

    def drop_tenant_from_apartment
      Apartment::Tenant.drop(domain)
    end

end
