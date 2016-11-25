class ElectionsParticipatedUser < ActiveRecord::Base

  belongs_to :election
  belongs_to :user

  def self.add_participations(selected, user_id)
    if ElectionsParticipatedUser.where("user_id = ? and election_id = ?", user_id, Election.last.id).blank? && selected == "true"
      epu = ElectionsParticipatedUser.new
      epu.user_id = user_id
      epu.election_id = Election.last.id
      epu.save
    else
      epu = ElectionsParticipatedUser.where("user_id = ? and election_id = ?", user_id, Election.last.id).first
      epu.delete if epu
    end
  end
end
