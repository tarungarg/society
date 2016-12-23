# == Schema Information
#
# Table name: tasks
#
#  id         :integer          not null, primary key
#  title      :string
#  desc       :text
#  date       :datetime
#  completed  :boolean          default("false")
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Task < ActiveRecord::Base
  validates :title, presence: true
end
