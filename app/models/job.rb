# == Schema Information
#
# Table name: jobs
#
#  id         :integer          not null, primary key
#  title      :string
#  desc       :text
#  user_id    :integer
#  files      :json
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Job < ActiveRecord::Base
  include PublicActivity::Model
  tracked

  acts_as_commontable
  validates :title, :desc, presence: true
  mount_uploaders :files, AvatarUploader
end
