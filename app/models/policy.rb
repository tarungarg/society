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
  include PublicActivity::Model
  tracked
  
  mount_uploader :file, AvatarUploader
  acts_as_readable on: :updated_at
  belongs_to :user
end
