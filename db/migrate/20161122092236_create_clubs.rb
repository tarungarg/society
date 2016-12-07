class CreateClubs < ActiveRecord::Migration
  def change
    create_table :clubs do |t|
      t.string :title
      t.text :desc
      t.datetime :from_time
      t.datetime :to_time

      t.timestamps null: false
    end
  end
end
