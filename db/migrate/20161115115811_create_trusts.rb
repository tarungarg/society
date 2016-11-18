class CreateTrusts < ActiveRecord::Migration
  def change
    create_table :trusts do |t|
      t.string :title
      t.text :desc
      t.date :from_date
      t.date :to_date
      t.integer :amount

      t.timestamps null: false
    end
  end
end
