class AddCarNumsToUser < ActiveRecord::Migration
  def change
    add_column :users, :car_nums, :text, array: true, default: []
  end
end
