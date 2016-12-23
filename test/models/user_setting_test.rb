# == Schema Information
#
# Table name: user_settings
#
#  id             :integer          not null, primary key
#  voting_visible :boolean          default("false")
#  tenant_id      :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

require 'test_helper'

class UserSettingTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
