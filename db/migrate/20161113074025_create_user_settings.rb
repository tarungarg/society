class CreateUserSettings < ActiveRecord::Migration
  def change
    create_table :user_settings do |t|
      t.boolean :voting_visible, default: false
      t.integer :tenant_id

      t.timestamps null: false
    end
  end
end
