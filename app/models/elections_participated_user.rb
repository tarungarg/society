# == Schema Information
#
# Table name: elections_participated_users
#
#  id          :integer          not null, primary key
#  user_id     :integer
#  election_id :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class ElectionsParticipatedUser < ActiveRecord::Base
  belongs_to :election
  belongs_to :user

  def self.add_participations(selected, user_id)
    if ElectionsParticipatedUser.where('user_id = ? and election_id = ?', user_id, Election.last.id).blank? && selected == 'true'
      epu = ElectionsParticipatedUser.new
      epu.user_id = user_id
      epu.election_id = Election.last.id
      epu.save
    else
      epu = ElectionsParticipatedUser.where('user_id = ? and election_id = ?', user_id, Election.last.id).first
      epu.delete if epu
    end
  end
end
