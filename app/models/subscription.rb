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
