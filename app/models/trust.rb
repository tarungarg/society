# == Schema Information
#
# Table name: trusts
#
#  id         :integer          not null, primary key
#  title      :string
#  desc       :text
#  from_date  :date
#  to_date    :date
#  amount     :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Trust < ActiveRecord::Base
  validates :title, presence: true
end
