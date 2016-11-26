class Charge < ActiveRecord::Base
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
