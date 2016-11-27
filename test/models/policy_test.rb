# == Schema Information
#
# Table name: policies
#
#  id         :integer          not null, primary key
#  name       :string
#  file       :string
#  body       :text
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'test_helper'

class PolicyTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
