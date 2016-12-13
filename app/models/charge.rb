# == Schema Information
#
# Table name: charges
#
#  id         :integer          not null, primary key
#  from_date  :date
#  to_date    :date
#  period     :integer
#  title      :string
#  desc       :text
#  amount     :integer
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Charge < ActiveRecord::Base
  include PublicActivity::Model
  tracked
  enum period: { Monthly: 0, Quaterly: 1, Yearly: 3 }

  has_many :subscriptions

  def to_date
    if period == 'Monthly'
      from_date + 1.month
    elsif period == 'Quaterly'
      from_date + 3.month
    elsif period == 'Yearly'
      from_date + 12.month
    end
  end
end
