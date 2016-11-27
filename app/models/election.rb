# == Schema Information
#
# Table name: elections
#
#  id                :integer          not null, primary key
#  voting_start_date :date
#  voting_end_date   :date
#  years_range       :string
#  win_user          :integer
#  win_by            :integer
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

class Election < ActiveRecord::Base
  has_many :elections_participated_users, dependent: :destroy

  def self.new_or_recent_election
    Tenant.current.user_setting.voting_visible
  end
end
