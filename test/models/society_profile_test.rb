# == Schema Information
#
# Table name: society_profiles
#
#  id            :integer          not null, primary key
#  user_id       :integer
#  society_name  :string
#  mobile_number :string
#  street_addr   :string
#  city          :string
#  state         :string
#  zip           :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

require 'test_helper'

class SocietyProfileTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
