# == Schema Information
#
# Table name: rents
#
#  id          :integer          not null, primary key
#  name        :string
#  desc        :text
#  flat_type   :integer
#  images      :json
#  street_addr :string
#  city        :string
#  state       :string
#  zip         :string
#  bhk         :integer
#  sale_by     :integer
#  amount      :integer
#  user_id     :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Rent < ActiveRecord::Base
  enum flat_types: { Sale: 0, Rent: 1 }
  enum sale_bys: { Owner: 0, Agent: 1, Other: 2 }

  ####
  # filterrific gem for search sort and pagination
  ####

  self.per_page = 10

  filterrific(
    default_filter_params: { sorted_by: 'created_at_desc' },
    available_filters: [
      :sorted_by,
      :search_query,
      :date_on
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
          'LOWER(rents.name) LIKE ?',
          'LOWER(rents.desc) LIKE ?'
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
      order("rents.created_at #{direction}")
    when /^name_/
      order("LOWER(rents.name) #{direction}")
    else
      raise(ArgumentError, "Invalid sort option: #{sort_key.inspect}")
    end
  }

  scope :date_on, lambda { |ref_date|
    where('rents.created_at >= ?', ref_date)
  }
end
