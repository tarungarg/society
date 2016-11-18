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
#  voting_visble          :boolean
#

class Member < User

end
