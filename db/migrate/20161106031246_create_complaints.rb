class CreateComplaints < ActiveRecord::Migration
  def change
    create_table :complaints do |t|
      t.string :title
      t.text :desc
      t.integer :status, default: 0
      t.integer :random, default: 0
      t.boolean :view_publically, default: false
      t.integer :user_id, null: false

      t.timestamps null: false
    end
    add_index :complaints, :status,       using: :btree
    add_index :complaints, :title,        using: :btree
  end
end
