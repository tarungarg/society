class CreatePolicies < ActiveRecord::Migration
  def change
    create_table :policies do |t|
      t.string :name
      t.string :file
      t.text :body
      t.integer :user_id

      t.timestamps null: false
    end
    add_index :policies, :user_id, using: :btree
    add_index :policies, :name, using: :btree
  end
end
