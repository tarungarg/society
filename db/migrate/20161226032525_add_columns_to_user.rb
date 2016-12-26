class AddColumnsToUser < ActiveRecord::Migration
  def change
    add_column :users, :payment_type, :integer
    add_column :users, :trial, :boolean, default: true
    add_column :users, :paid_on, :datetime
  end
end
