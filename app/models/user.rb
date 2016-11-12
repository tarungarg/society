class User < ActiveRecord::Base
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  belongs_to :tenant
  has_one :society_profile, dependent: :destroy
  has_many :complaints

  accepts_nested_attributes_for :society_profile, allow_destroy: true, reject_if: :all_blank
  accepts_nested_attributes_for :tenant, allow_destroy: true, reject_if: :all_blank


  after_create :add_tenant_to_apartment

  enum profile_roles: [:president, :member, :labour, :POE]

  acts_as_commontator
  acts_as_voter
  acts_as_reader

  has_many :policies

####
# filterrific gem for search sort and pagination
#### 

  self.per_page = 10

  filterrific(
    default_filter_params: { sorted_by: 'created_at_desc' },
    available_filters: [
      :sorted_by,
      :search_query,
      :flat_no_search,
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
    num_or_conditions = 5
    where(
      terms.map {
        or_clauses = [
          "LOWER(users.name) LIKE ?",
          "LOWER(users.email) LIKE ?",
          "LOWER(users.mob_num) LIKE ?",
          "LOWER(users.occupation) LIKE ?",
          "LOWER(users.bio) LIKE ?"
        ].join(' OR ')
        "(#{ or_clauses })"
      }.join(' AND '),
      *terms.map { |e| [e] * num_or_conditions }.flatten
    )
  }

  scope :flat_no_search, lambda { |query|
    return nil  if query.blank?
    where(["users.flat_no = ?", query.to_s])
  }

  scope :sorted_by, lambda { |sort_key|
    direction = (sort_key =~ /desc$/) ? 'desc' : 'asc'
    case sort_key.to_s
    when /^created_at_/
      order("users.created_at #{ direction }")
    when /^name_/
      order("LOWER(users.name) #{ direction }")
    when /^number_/
      order("LOWER(users.mob_num) #{ direction }")
    when /^flat_no_/
      order("LOWER(users.flat_no) #{ direction }")
    when /^email_/
      order("LOWER(users.email) #{ direction }")
    when /^blood_/
      order("LOWER(users.blood_group) #{ direction }")
    else
      raise(ArgumentError, "Invalid sort option: #{ sort_key.inspect }")
    end
  }

  scope :with_created_at_gte, lambda { |ref_date|
    where('users.created_at >= ?', ref_date)
  }


  # to show society profile attributes with user
  # Showing signup for with society profile attributes
  def society_profile
    super || build_society_profile
  end

  def tenant
    super || build_tenant
  end

  def tenant_domain
    tenant.domain
  end

  def set_default_role
    self.add_role :president
  end

  def is_candidate?
    candidate
  end

  private

    def add_tenant_to_apartment
      unless Tenant.current
        set_default_role
        Apartment::Tenant.create(tenant.domain)
        Apartment::Tenant.switch!(tenant.domain)
      end
    end

end
