class Election < ActiveRecord::Base
  has_many :elections_participated_users
end
