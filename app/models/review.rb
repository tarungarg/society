# == Schema Information
#
# Table name: reviews
#
#  id           :integer          not null, primary key
#  review       :text
#  complaint_id :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Review < ActiveRecord::Base
  belongs_to :complaint, touch: true
  validates :review, presence: true
end
