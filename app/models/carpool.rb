# == Schema Information
#
# Table name: carpools
#
#  id         :integer          not null, primary key
#  title      :string
#  desc       :text
#  user_id    :integer
#  date       :datetime
#  routes     :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Carpool < ActiveRecord::Base
  acts_as_taggable
  acts_as_taggable_on :routes
end
