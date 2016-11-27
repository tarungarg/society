# == Schema Information
#
# Table name: funds
#
#  id         :integer          not null, primary key
#  amount     :integer
#  title      :string
#  desc       :string
#  date       :datetime
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'test_helper'

class FundTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
