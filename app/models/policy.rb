# == Schema Information
#
# Table name: policies
#
#  id         :integer          not null, primary key
#  name       :string
#  file       :string
#  body       :text
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Policy < ActiveRecord::Base
  mount_uploader :file, AvatarUploader
  acts_as_readable on: :updated_at
  belongs_to :user

  include PublicActivity::Model
  tracked except: :destroy, owner: proc { |controller, _model| controller.current_user ? controller.current_user : nil }, recipient: proc { |_controller, model| model && model.user }
end
