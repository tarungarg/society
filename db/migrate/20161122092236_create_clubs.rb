class CreateClubs < ActiveRecord::Migration
  def change
    create_table :clubs do |t|
      t.string :title
      t.text :desc
      t.date :date
      t.time :from_time
      t.time :to_time

      t.timestamps null: false
    end
  end
end
