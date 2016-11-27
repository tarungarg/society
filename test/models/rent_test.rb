# == Schema Information
#
# Table name: rents
#
#  id          :integer          not null, primary key
#  name        :string
#  desc        :text
#  flat_type   :integer
#  images      :json
#  street_addr :string
#  city        :string
#  state       :string
#  zip         :string
#  bhk         :integer
#  sale_by     :integer
#  amount      :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'test_helper'

class RentTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
