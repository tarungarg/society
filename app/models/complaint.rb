class Complaint < ActiveRecord::Base

  validates :title, :desc, presence: true
  validates :desc, length: { minimum: 10 }

  acts_as_votable
  acts_as_commontable

  enum status: [ 'Not Resolved', 'Resolved']

  belongs_to :user

  # after_destroy :destroy_other_contents
  has_many :reviews


####
# filterrific gem for search sort and pagination
#### 

  self.per_page = 10

  filterrific(
    default_filter_params: { sorted_by: 'created_at_desc' },
    available_filters: [
      :search_query,
      :sorted_by,
      # :search_public_complaints,
      :with_created_at_gte
    ]
  )

  scope :search_query, lambda { |query|
    return nil  if query.blank?
    # condition query, parse into individual keywords
    terms = query.downcase.split(/\s+/)
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
          "LOWER(complaints.title) LIKE ?",
          "LOWER(complaints.desc) LIKE ?",
        ].join(' OR ')
        "(#{ or_clauses })"
      }.join(' AND '),
      *terms.map { |e| [e] * num_or_conditions }.flatten
    )
  }


  scope :sorted_by, lambda { |sort_key|
    direction = (sort_key =~ /desc$/) ? 'desc' : 'asc'
    case sort_key.to_s
    when /^created_at_/
      order("complaints.created_at #{ direction }")
    else
      raise(ArgumentError, "Invalid sort option: #{ sort_key.inspect }")
    end
  }

  scope :with_created_at_gte, lambda { |ref_date|
    where('complaints.created_at >= ?', ref_date)
  }


  private

    def destroy_other_contents
    end
end
