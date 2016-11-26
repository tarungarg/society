class Election < ActiveRecord::Base
  has_many :elections_participated_users, dependent: :destroy

  def self.new_or_recent_election
    Tenant.current.user_setting.voting_visible
  end

end
