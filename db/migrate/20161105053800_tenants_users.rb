class TenantsUsers < ActiveRecord::Migration
  def change
    create_table :tenants_users do |t|
      t.integer :user_id,             null: false
      t.integer :tenant_id,           null: false
    end
     add_index "tenants_users", ["user_id"], name: "index_tenants_users_on_user_id", using: :btree
     add_index "tenants_users", ["tenant_id"], name: "index_tenants_users_on_tenants_id", using: :btree
  end
end
