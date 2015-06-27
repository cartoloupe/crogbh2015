class CreateAdminUserDetails < ActiveRecord::Migration
  def change
    create_table :admin_user_details do |t|
      t.timestamps null: false
    end
  end
end
