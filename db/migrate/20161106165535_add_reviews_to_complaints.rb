class AddReviewsToComplaints < ActiveRecord::Migration
  def change
    add_column :complaints, :review, :text
  end
end
