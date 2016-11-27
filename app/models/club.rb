# == Schema Information
#
# Table name: clubs
#
#  id         :integer          not null, primary key
#  title      :string
#  desc       :text
#  date       :date
#  from_time  :time
#  to_time    :time
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Club < ActiveRecord::Base
end
