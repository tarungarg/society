class AddMissingIndexesLol < ActiveRecord::Migration
  def change
    add_index :commontator_comments, [:editor_id, :editor_type]
    add_index :commontator_threads, [:closer_id, :closer_type]
    add_index :complaints, :user_id
    add_index :elections_participated_users, :election_id
    add_index :elections_participated_users, :user_id
    add_index :posts, :user_id
    add_index :society_profiles, :user_id
    add_index :subscriptions, :charge_id
    add_index :subscriptions, :user_id
    add_index :user_settings, :tenant_id
  end
end
