class CreateSubscriptions < ActiveRecord::Migration
  def change
    create_table :subscriptions do |t|
      t.integer :charge_id
      t.integer :user_id
      t.integer :paid

      t.timestamps null: false
    end
  end
end
