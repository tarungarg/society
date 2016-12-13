class Post < ActiveRecord::Base
  mount_uploader :attachment, AvatarUploader
  belongs_to :user
  acts_as_commontable
  
  include PublicActivity::Model
  tracked
end
