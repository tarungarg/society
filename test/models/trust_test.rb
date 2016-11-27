# == Schema Information
#
# Table name: trusts
#
#  id         :integer          not null, primary key
#  title      :string
#  desc       :text
#  from_date  :date
#  to_date    :date
#  amount     :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'test_helper'

class TrustTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
