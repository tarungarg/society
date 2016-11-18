# == Schema Information
#
# Table name: announcements
#
#  id         :integer          not null, primary key
#  body       :text
#  desc       :text
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Announcement < ActiveRecord::Base

  validates :title, :desc, presence: true

  acts_as_readable :on => :updated_at
  
  def self.newest
    Announcement.last
  end
  
  def self.newest_private
    Announcement.where("type is null").order("id desc").first
  end

  def self.newest_public
    Announcement.where("type = 'public'").order("id desc").first
  end
  
end
