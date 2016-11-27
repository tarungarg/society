# == Schema Information
#
# Table name: subscriptions
#
#  id         :integer          not null, primary key
#  charge_id  :integer
#  user_id    :integer
#  paid       :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'test_helper'

class SubscriptionTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
