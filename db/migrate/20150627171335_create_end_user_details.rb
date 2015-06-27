class CreateEndUserDetails < ActiveRecord::Migration
  def change
    create_table :end_user_details do |t|
      # some culture's names can compound and get very long
      t.string :first_name,     limit: 70
      t.string :last_name,      limit: 70

      # 40 the usps limit on line length
      t.string :address_line_1, limit: 40
      t.string :address_line_2, limit: 40
      t.string :address_line_3, limit: 40

      # 23 is the length of the longest city name in the US:
      #   "Bellefontaine Neighbors"
      t.string :city,           limit: 22

      # All US regions have a 2 digit code
      t.string :state,          limit: 2

      # Store either 5 or 9 chars
      #   Remove hyphen for storage
      #   Add hyphen for display
      t.string :zip,            limit: 9

      # 'M' or 'F' for now.. how to handle non-binary?
      t.string :gender,         limit: 1

      # Store 10 chars
      #   Store only area code, exchange, and station digits
      #   Add country code and separators for display
      t.string :phone_number,   limit: 10

      t.timestamps null: false
    end
  end
end
