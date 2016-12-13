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
  include BannedWords
  has_many :users
  has_one :user_setting
  before_save :valid_domain

  validates :domain,
    presence: true,
    uniqueness: { case_sensitive: false },
    length: {
      in: 2..20,
      message: 'The web address must be minimum 4 and maximum 20 characters.'
    },
    format: {
      with: /^[a-zA-Z0-9\-'\_]+$/,
      message: 'The url contains an invalid character or a space.',
      multiline: true
    }

  # after_create :add_tenant_to_apartment

  def self.current
    tenant = Tenant.find_by domain: Apartment::Tenant.current
    tenant
  end

  def has_presidents
    roles = Tenant.current.users.map(&:roles)
    count = 0
    roles.flatten.each { |c| count += 1 if c.name == 'president' }
    count > 1
  end

  def valid_domain
    domain.downcase!
    if banned_urls(domain)
      errors.add(:domain, 'This subdomain url is not allowed.')
      false
    else
      true
    end
  end

  private

  def drop_tenant_from_apartment
    Apartment::Tenant.drop(domain)
  end


end
