class CreateAnnouncements < ActiveRecord::Migration
  def change
    create_table :announcements do |t|
      t.text :body
      t.text :desc
      t.string :title

      t.timestamps null: false
    end
  end
end
