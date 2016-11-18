# == Schema Information
#
# Table name: society_profiles
#
#  id            :integer          not null, primary key
#  user_id       :integer
#  society_name  :string
#  mobile_number :string
#  street_addr   :string
#  city          :string
#  state         :string
#  zip           :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class SocietyProfile < ActiveRecord::Base
  belongs_to :user
end
