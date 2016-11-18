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

class Banner < ActiveRecord::Base
  mount_uploader :desktop_image, AvatarUploader
  mount_uploader :mobile_image, AvatarUploader
  validates :desktop_key, :mobile_key, uniqueness: true
  validates :mobile_key, :desktop_key, presence: true
end
