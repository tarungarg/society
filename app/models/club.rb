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
  before_save :check_time_slot
  validates :title, presence: true

  def date
    created_at
  end

  private

  def check_time_slot
    unless Club.where(from_time: from_time..to_time).blank? || 
                      Club.where(to_time: from_time..to_time).blank?
      errors.add(:base, "There is already an event on this date or timings. Please select other timings or date.")
      false
    end
  end

end
