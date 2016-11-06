class CreateComplaints < ActiveRecord::Migration
  def change
    create_table :complaints do |t|
      t.string :title
      t.text :desc
      t.integer :status

      t.timestamps null: false
    end
  end
end
