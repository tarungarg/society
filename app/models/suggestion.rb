# == Schema Information
#
# Table name: suggestions
#
#  id         :integer          not null, primary key
#  title      :string
#  desc       :text
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Suggestion < ActiveRecord::Base
  include DestoryComments
  acts_as_commontable
  validates :title, :desc, presence: true
end
