class CreateEndUserDetail < ActiveRecord::Migration
  def change
    create_table :end_user_details do |t|
      t.string :city, limit: 22
      t.string :state, limit: 2
      t.string :zip, limit: 9
      t.string :gender, limit: 9
      t.string :phone, limit: 10
      t.text :address
    end
  end
end
