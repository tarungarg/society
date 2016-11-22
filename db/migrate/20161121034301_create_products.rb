class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name
      t.string :desc
      t.json :images
      t.integer :amount

      t.timestamps null: false
    end
  end
end
