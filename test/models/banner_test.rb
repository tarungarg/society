# == Schema Information
#
# Table name: banners
#
#  id            :integer          not null, primary key
#  desktop_image :string
#  mobile_image  :string
#  mobile_key    :string
#  desktop_key   :string
#  desktop_size  :string
#  mobile_size   :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

require 'test_helper'

class BannerTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
