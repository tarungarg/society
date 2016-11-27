# == Schema Information
#
# Table name: charges
#
#  id         :integer          not null, primary key
#  from_date  :date
#  to_date    :date
#  period     :integer
#  title      :string
#  desc       :text
#  amount     :integer
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'test_helper'

class ChargeTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
