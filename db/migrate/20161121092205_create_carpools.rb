class CreateCarpools < ActiveRecord::Migration
  def change
    create_table :carpools do |t|
      t.string :title
      t.text :desc
      t.integer :user_id
      t.datetime :date
      t.string :routes

      t.timestamps null: false
    end
  end
end
