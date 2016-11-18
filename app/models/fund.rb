# == Schema Information
#
# Table name: funds
#
#  id         :integer          not null, primary key
#  amount     :integer
#  title      :string
#  desc       :string
#  date       :datetime
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Fund < ActiveRecord::Base
  validates :title , :amount, presence: true

  scope :created_between, lambda {|start_date, end_date| where("created_at >= ? AND created_at <= ?", start_date, end_date )}

####
# filterrific gem for search sort and pagination
#### 

  self.per_page = 10

  filterrific(
    default_filter_params: { sorted_by: 'created_at_desc' },
    available_filters: [
      :sorted_by,
      :search_query,
      :amount_search,
      :with_created_at_gte,
      :with_dates
    ]
  )

  scope :search_query, lambda { |query|
    return nil  if query.blank?
    # condition query, parse into individual keywords
    terms = query.to_s.downcase.split(/\s+/)
    # replace "*" with "%" for wildcard searches,
    # append '%', remove duplicate '%'s
    terms = terms.map { |e|
      ('%' + e.gsub('*', '%') + '%').gsub(/%+/, '%')
    }
    # configure number of OR conditions for provision
    # of interpolation arguments. Adjust this if you
    # change the number of OR conditions.
    num_or_conditions = 2
    where(
      terms.map {
        or_clauses = [
          "LOWER(funds.title) LIKE ?",
          "LOWER(funds.desc) LIKE ?",
        ].join(' OR ')
        "(#{ or_clauses })"
      }.join(' AND '),
      *terms.map { |e| [e] * num_or_conditions }.flatten
    )
  }

  scope :amount_search, lambda { |query|
    return nil  if query.blank?
    where(["funds.amount = ?", query])
  }

  scope :sorted_by, lambda { |sort_key|
    direction = (sort_key =~ /desc$/) ? 'desc' : 'asc'
    case sort_key.to_s
    when /^created_at_/
      order("funds.created_at #{ direction }")
    when /^name_/
      order("LOWER(funds.name) #{ direction }")
    when /^number_/
      order("LOWER(funds.mob_num) #{ direction }")
    when /^flat_no_/
      order("LOWER(funds.flat_no) #{ direction }")
    when /^email_/
      order("LOWER(funds.email) #{ direction }")
    when /^blood_/
      order("LOWER(funds.blood_group) #{ direction }")
    else
      raise(ArgumentError, "Invalid sort option: #{ sort_key.inspect }")
    end
  }

  scope :with_created_at_gte, lambda { |ref_date|
    where('funds.date >= ?', ref_date)
  }


  scope :with_dates, lambda { |date|
    where('funds.date >= ?', date)
  }

  def self.total_spent
    Fund.sum(:amount)
  end

  def self.period_total_spent(from, to)
    Fund.created_between(from, to).sum(:amount)
  end

  def self.yearly_spent(year)
    Fund.where('extract(year from date) = ?', year).sum(:amount)
  end

  # def self.month_spent(month)
  #   Fund.where('extract(month from date) = ?', month).sum(:amount)
  # end

end
