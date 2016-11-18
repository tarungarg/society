# == Schema Information
#
# Table name: public.tenants
#
#  id         :integer          not null, primary key
#  name       :string
#  domain     :string
#  image_url  :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Tenant < ActiveRecord::Base
  has_many :users
  has_one :user_setting

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
