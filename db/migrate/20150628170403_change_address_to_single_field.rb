class ChangeAddressToSingleField < ActiveRecord::Migration
  def up
    remove_column :end_user_details, :address_line_1
    remove_column :end_user_details, :address_line_2
    remove_column :end_user_details, :address_line_3
    add_column :end_user_details, :address, :text
  end

  def down
    remove_column :end_user_details, :address
    add_column :end_user_details, :address_line_1, :string, limit: 40
    add_column :end_user_details, :address_line_2, :string, limit: 40
    add_column :end_user_details, :address_line_3, :string, limit: 40
  end
end
