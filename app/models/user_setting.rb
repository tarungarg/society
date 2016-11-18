# == Schema Information
#
# Table name: user_settings
#
#  id             :integer          not null, primary key
#  voting_visible :boolean          default(FALSE)
#  tenant_id      :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

class UserSetting < ActiveRecord::Base
  belongs_to :tenant
end
