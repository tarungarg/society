# == Schema Information
#
# Table name: complaints
#
#  id              :integer          not null, primary key
#  title           :string
#  desc            :text
#  status          :integer          default("0")
#  random          :integer          default("0")
#  view_publically :boolean          default("false")
#  user_id         :integer          not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

require 'test_helper'

class ComplaintTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
