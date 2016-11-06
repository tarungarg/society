class CreateSocietyProfiles < ActiveRecord::Migration
  def change
    create_table :society_profiles do |t|
      t.integer :user_id
      t.string :society_name
      t.string :mobile_number
      t.string :street_addr
      t.string :city
      t.string :state
      t.string :zip

      t.timestamps null: false
    end
  end
end
