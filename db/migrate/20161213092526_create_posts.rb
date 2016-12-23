class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.json :attachments
      t.text :content
      t.integer :user_id # , index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
