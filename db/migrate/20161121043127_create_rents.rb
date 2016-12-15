class CreateRents < ActiveRecord::Migration
  def change
    create_table :rents do |t|
      t.string :name
      t.text :desc
      t.integer :flat_type
      t.json :images
      t.string :street_addr
      t.string :city
      t.string :state
      t.string :zip
      t.integer :bhk
      t.integer :sale_by
      t.integer :amount
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
