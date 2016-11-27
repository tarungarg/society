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
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Rent < ActiveRecord::Base
  enum flat_types: { Sale: 0, Rent: 1 }
  enum sale_bys: { Owner: 0, Agent: 1, Other: 2 }
end
