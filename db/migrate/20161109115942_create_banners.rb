class CreateBanners < ActiveRecord::Migration
  def change
    create_table :banners do |t|
      t.string :desktop_image
      t.string :mobile_image
      t.string :mobile_url
      t.string :desktop_url
      t.string :desktop_size
      t.string :mobile_size
      t.integer :area, default: 0

      t.timestamps null: false
    end
  end
end
