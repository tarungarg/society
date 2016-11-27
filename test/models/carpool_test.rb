# == Schema Information
#
# Table name: carpools
#
#  id         :integer          not null, primary key
#  title      :string
#  desc       :text
#  user_id    :integer
#  date       :datetime
#  routes     :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'test_helper'

class CarpoolTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
