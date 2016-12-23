# == Schema Information
#
# Table name: clubs
#
#  id         :integer          not null, primary key
#  title      :string
#  desc       :text
#  from_time  :datetime
#  to_time    :datetime
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'test_helper'

class ClubTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
