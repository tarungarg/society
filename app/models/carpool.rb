# == Schema Information
#
# Table name: carpools
#
#  id         :integer          not null, primary key
#  amount     :integer
#  from       :string
#  to         :string
#  desc       :text
#  user_id    :integer
#  date       :datetime
#  routes     :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Carpool < ActiveRecord::Base
  validates :from, :to, :desc, :date, :amount, presence: true
  acts_as_taggable
  acts_as_taggable_on :routes

  ####
  # filterrific gem for search sort and pagination
  ####

  self.per_page = 10

  filterrific(
    default_filter_params: { sorted_by: 'created_at_desc' },
    available_filters: [
      :sorted_by,
      :search_from,
      :search_to,
      :search_query,
      :via,
      :date_on
    ]
  )

  scope :search_from, lambda { |query|
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
    num_or_conditions = 1
    where(
      terms.map do
        or_clauses = [
          'LOWER(carpools.from) LIKE ?'
        ].join(' OR ')
        "(#{or_clauses})"
      end.join(' AND '),
      *terms.map { |e| [e] * num_or_conditions }.flatten
    )
  }

  scope :search_to, lambda { |query|
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
    num_or_conditions = 1
    where(
      terms.map do
        or_clauses = [
          'LOWER(carpools.to) LIKE ?'
        ].join(' OR ')
        "(#{or_clauses})"
      end.join(' AND '),
      *terms.map { |e| [e] * num_or_conditions }.flatten
    )
  }

  scope :search_query_from, lambda { |query|
    return nil if query.blank?
    where(['carpools.from LIKE ?', '%' + query.to_s + '%'])
  }

  scope :search_query_to, lambda { |query|
    return nil if query.blank?
    where(['carpools.to LIKE ?', '%' + query.to_s + '%'])
  }

  scope :sorted_by, lambda { |sort_key|
    direction = sort_key =~ /desc$/ ? 'desc' : 'asc'
    case sort_key.to_s
    when /^created_at_/
      order("carpools.created_at #{direction}")
    when /^name_/
      order("LOWER(carpools.name) #{direction}")
    else
      raise(ArgumentError, "Invalid sort option: #{sort_key.inspect}")
    end
  }

  scope :date_on, lambda { |ref_date|
    where('carpools.date >= ?', ref_date)
  }

  scope :via, lambda { |query|
    tagged_with(query, any: true, wild: true)
  }
end
