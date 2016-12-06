# == Schema Information
#
# Table name: public.users
#
#  id                     :integer          not null, primary key
#  name                   :string
#  flat_no                :string
#  tower_no               :string
#  alt_no                 :string
#  blood_group            :string
#  occupation             :string
#  family_memebers        :integer          default(0)
#  adult                  :integer          default(0)
#  kids                   :integer          default(0)
#  bio                    :text
#  candidate              :boolean          default(FALSE)
#  mob_num                :string           default("")
#  email                  :string           default("")
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :inet
#  last_sign_in_ip        :inet
#  tenant_id              :integer
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  invitation_token       :string
#  invitation_created_at  :datetime
#  invitation_sent_at     :datetime
#  invitation_accepted_at :datetime
#  invitation_limit       :integer
#  invited_by_id          :integer
#  invited_by_type        :string
#  invitations_count      :integer          default(0)
#

class User < ActiveRecord::Base
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  belongs_to :tenant
  has_one :society_profile, dependent: :destroy
  has_one :user_setting
  has_many :complaints
  has_many :policies
  has_many :invitations, class_name: to_s, as: :invited_by
  has_many :charge_subscriptions, class_name: 'Subscription'
  has_many :elections_participated_users
  has_many :jobs, dependent: :destroy
  has_many :suggestions, dependent: :destroy
  has_many :products, dependent: :destroy
  has_many :car_pools, dependent: :destroy

  accepts_nested_attributes_for :society_profile, allow_destroy: true, reject_if: :all_blank
  accepts_nested_attributes_for :tenant, allow_destroy: true, reject_if: :all_blank

  after_create :add_tenant_to_apartment

  enum profile_roles: [:president, :member, :labour, :POE]

  acts_as_commontator
  acts_as_voter
  acts_as_reader
  acts_as_votable
  acts_as_messageable

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
    num_or_conditions = 5
    where(
      terms.map do
        or_clauses = [
          'LOWER(users.name) LIKE ?',
          'LOWER(users.email) LIKE ?',
          'LOWER(users.mob_num) LIKE ?',
          'LOWER(users.occupation) LIKE ?',
          'LOWER(users.bio) LIKE ?'
        ].join(' OR ')
        "(#{or_clauses})"
      end.join(' AND '),
      *terms.map { |e| [e] * num_or_conditions }.flatten
    )
  }

  scope :flat_no_search, lambda { |query|
    return nil if query.blank?
    where(['users.flat_no = ?', query.to_s])
  }

  scope :sorted_by, lambda { |sort_key|
    direction = sort_key =~ /desc$/ ? 'desc' : 'asc'
    case sort_key.to_s
    when /^created_at_/
      order("users.created_at #{direction}")
    when /^name_/
      order("LOWER(users.name) #{direction}")
    when /^number_/
      order("LOWER(users.mob_num) #{direction}")
    when /^flat_no_/
      order("LOWER(users.flat_no) #{direction}")
    when /^email_/
      order("LOWER(users.email) #{direction}")
    when /^blood_/
      order("LOWER(users.blood_group) #{direction}")
    else
      raise(ArgumentError, "Invalid sort option: #{sort_key.inspect}")
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

  def is_candidate?
    candidate
  end

  def has_voted?
    !votes.up.for_type(User).where(vote_scope: 'elect').blank?
  end

  def has_voted_to?(member)
    voted_for? member, vote_scope: 'elect'
  end

  def calculate_votes_size
    find_votes_for(vote_scope: 'elect').size
  end

  def mailboxer_name
    self.name
  end

  def mailboxer_email(object)
    self.email
  end

  private

  def add_tenant_to_apartment
    if !Tenant.current || Tenant.current.domain == 'me'
      Apartment::Tenant.create(tenant.domain)
      Apartment::Tenant.switch!(tenant.domain)
      set_default_role
      set_default_setting
    end
  end

  def set_default_role
    add_role :president
  end

  def set_default_setting
    UserSetting.create(tenant_id: Tenant.current.id)
  end
end
