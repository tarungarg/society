class Suggestion < ActiveRecord::Base
  acts_as_commontable
  validates :title, :desc, presence: true
end
