class CreateRents < ActiveRecord::Migration
  def change
    create_table :rents do |t|
      t.string :name
      t.text :desc
      t.integer :flat_type
      t.json :images
      t.integer :amount

      t.timestamps null: false
    end
  end
end
