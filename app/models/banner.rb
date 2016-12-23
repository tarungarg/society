# == Schema Information
#
# Table name: banners
#
#  id            :integer          not null, primary key
#  desktop_image :string
#  mobile_image  :string
#  mobile_url    :string
#  desktop_url   :string
#  desktop_size  :string
#  mobile_size   :string
#  area          :integer          default("0")
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class Banner < ActiveRecord::Base
  mount_uploader :desktop_image, ImageUploader
  mount_uploader :mobile_image, AvatarUploader
  validates :area, presence: true, uniqueness: true
  validates :desktop_image, presence: true

  enum area: [:Dashboard, :Member, :Election, :Job, :Carpool, :Suggestions, :MemberShow]
end
