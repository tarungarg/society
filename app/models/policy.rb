class Policy < ActiveRecord::Base
  mount_uploader :file, AvatarUploader
  acts_as_readable :on => :updated_at
  belongs_to :user
end
