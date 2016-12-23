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
#  family_memebers        :integer          default("0")
#  adult                  :integer          default("0")
#  kids                   :integer          default("0")
#  bio                    :text
#  candidate              :boolean          default("false")
#  mob_num                :string           default("")
#  email                  :string           default("")
#  avatar                 :string
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default("0"), not null
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
#  invitations_count      :integer          default("0")
#  car_nums               :text             default("{}"), is an Array
#

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
