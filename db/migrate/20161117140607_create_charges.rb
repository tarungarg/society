class CreateCharges < ActiveRecord::Migration
  def change
    create_table :charges do |t|
      t.date :from_date
      t.date :to_date
      t.integer :period
      t.integer :amount
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
