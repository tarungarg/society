class CreateFunds < ActiveRecord::Migration
  def change
    create_table :funds do |t|
      t.integer :amount
      t.string :title
      t.string :desc
      t.datetime :date

      t.timestamps null: false
    end
  end
end
