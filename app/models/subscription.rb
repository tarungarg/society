# == Schema Information
#
# Table name: subscriptions
#
#  id         :integer          not null, primary key
#  charge_id  :integer
#  user_id    :integer
#  paid       :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Subscription < ActiveRecord::Base
  belongs_to :charge
  belongs_to :user

  def self.create_subscription(charge_id, user_id)
    subscription = Subscription.new
    subscription.user_id = user_id
    subscription.charge_id = charge_id
    subscription.save!
  end
end
