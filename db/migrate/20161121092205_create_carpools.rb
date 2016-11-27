class CreateCarpools < ActiveRecord::Migration
  def change
    create_table :carpools do |t|
      t.integer :amount
      t.string :from
      t.string :to
      t.text :desc
      t.integer :user_id
      t.datetime :date
      t.string :routes


      t.timestamps null: false
    end
  end
end
