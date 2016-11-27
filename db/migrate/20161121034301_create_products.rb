class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name
      t.text :desc
      t.json :images
      t.integer :amount
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
