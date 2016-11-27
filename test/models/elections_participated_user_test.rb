# == Schema Information
#
# Table name: elections_participated_users
#
#  id          :integer          not null, primary key
#  user_id     :integer
#  election_id :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'test_helper'

class ElectionsParticipatedUserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
