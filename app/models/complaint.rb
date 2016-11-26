# == Schema Information
#
# Table name: complaints
#
#  id              :integer          not null, primary key
#  title           :string
#  desc            :text
#  status          :integer          default(0)
#  random          :integer          default(0)
#  view_publically :boolean          default(FALSE)
#  user_id         :integer          not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class Complaint < ActiveRecord::Base
  validates :title, :desc, presence: true
  validates :desc, length: { minimum: 10 }

  acts_as_votable
  acts_as_commontable

  acts_as_readable on: :updated_at

  enum status: ['Not Resolved', 'Resolved']

  belongs_to :user

  has_many :reviews

  scope :public_comaplaints, -> { where('view_publically >= ?', true) }

  default_scope { order('complaints.status asc') }

  ####
  # filterrific gem for search sort and pagination
  ####

  self.per_page = 10

  filterrific(
    default_filter_params: { sorted_by: 'created_at_desc' },
    available_filters: [
      :search_query,
      :sorted_by,
      :with_created_at_gte
    ]
  )

  scope :search_query, lambda { |query|
    return nil if query.blank?
    # condition query, parse into individual keywords
    terms = query.to_s.downcase.split(/\s+/)
    # replace "*" with "%" for wildcard searches,
    # append '%', remove duplicate '%'s
    terms = terms.map do |e|
      ('%' + e.tr('*', '%') + '%').gsub(/%+/, '%')
    end
    # configure number of OR conditions for provision
    # of interpolation arguments. Adjust this if you
    # change the number of OR conditions.
    num_or_conditions = 2
    where(
      terms.map do
        or_clauses = [
          'LOWER(complaints.title) LIKE ?',
          'LOWER(complaints.desc) LIKE ?'
        ].join(' OR ')
        "(#{or_clauses})"
      end.join(' AND '),
      *terms.map { |e| [e] * num_or_conditions }.flatten
    )
  }

  scope :sorted_by, lambda { |sort_key|
    direction = sort_key =~ /desc$/ ? 'desc' : 'asc'
    case sort_key.to_s
    when /^created_at_/
      order("complaints.created_at #{direction}")
    when /^group_by_/
      order("complaints.status #{direction}")
    else
      raise(ArgumentError, "Invalid sort option: #{sort_key.inspect}")
    end
  }

  scope :with_created_at_gte, lambda { |ref_date|
    where('complaints.created_at >= ?', ref_date)
  }

  def self.clean_up_read_complains
    Complaint.cleanup_read_marks!
  end
end
