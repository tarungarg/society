class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.text :review
      t.integer :complaint_id

      t.timestamps null: false
    end

    add_index :reviews, :complaint_id,       using: :btree
  end
end
