# == Schema Information
#
# Table name: products
#
#  id         :integer          not null, primary key
#  name       :string
#  desc       :text
#  images     :json
#  amount     :integer
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
