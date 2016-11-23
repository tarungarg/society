class CreateElections < ActiveRecord::Migration
  def change
    create_table :elections do |t|
      t.date :voting_start_date
      t.date :voting_end_date
      t.string :years_range
      t.integer :win_user

      t.timestamps null: false
    end
  end
end
