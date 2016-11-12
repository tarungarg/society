class Banner < ActiveRecord::Base
  mount_uploader :desktop_image, AvatarUploader
  mount_uploader :mobile_image, AvatarUploader
  validates :desktop_key, :mobile_key, uniqueness: true
  validates :mobile_key, :desktop_key, presence: true
end
