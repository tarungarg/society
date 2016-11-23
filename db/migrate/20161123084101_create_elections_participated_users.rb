class CreateElectionsParticipatedUsers < ActiveRecord::Migration
  def change
    create_table :elections_participated_users do |t|
      t.integer :user_id
      t.integer :electon_id

      t.timestamps null: false
    end
  end
end
