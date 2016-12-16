class Post < ActiveRecord::Base
  mount_uploader :attachment, AvatarUploader
  belongs_to :user
  acts_as_commontable
  acts_as_votable
  acts_as_readable on: :updated_at

  include PublicActivity::Model
  tracked except: [:update, :destroy], owner: Proc.new { |controller, model| controller.current_user ? controller.current_user : nil }, recipient: Proc.new { |controller, model|  model && model.user }
end
