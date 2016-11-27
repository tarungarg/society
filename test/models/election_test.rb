# == Schema Information
#
# Table name: elections
#
#  id                :integer          not null, primary key
#  voting_start_date :date
#  voting_end_date   :date
#  years_range       :string
#  win_user          :integer
#  win_by            :integer
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

require 'test_helper'

class ElectionTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
