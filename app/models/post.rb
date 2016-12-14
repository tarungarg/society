class Post < ActiveRecord::Base
  mount_uploader :attachment, AvatarUploader
  belongs_to :user
  acts_as_commontable
  acts_as_votable
  
  include PublicActivity::Model
  tracked
end
