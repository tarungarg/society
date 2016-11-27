# == Schema Information
#
# Table name: announcements
#
#  id         :integer          not null, primary key
#  body       :text
#  desc       :text
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'test_helper'

class AnnouncementTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
