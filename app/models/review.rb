class Review < ActiveRecord::Base
  belongs_to :complaint, touch: true
  validates :review, presence: true
end
