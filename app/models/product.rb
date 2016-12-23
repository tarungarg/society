# == Schema Information
#
# Table name: products
#
#  id         :integer          not null, primary key
#  name       :string
#  desc       :text
#  images     :json
#  amount     :integer
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Product < ActiveRecord::Base
  mount_uploaders :images, ImageUploader
  validates :name, :desc, :amount, presence: true
  validates :amount, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
end
