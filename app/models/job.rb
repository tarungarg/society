class Job < ActiveRecord::Base
  acts_as_commontable
  validates :title, :desc, presence: true
  mount_uploaders :files, AvatarUploader
end
