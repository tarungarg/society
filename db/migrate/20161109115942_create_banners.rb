class CreateBanners < ActiveRecord::Migration
  def change
    create_table :banners do |t|
      t.json :images
      t.string :mobile_key
      t.string :desktop_key
      t.string :desktop_size
      t.string :mobile_size

      t.timestamps null: false
    end
  end
end
