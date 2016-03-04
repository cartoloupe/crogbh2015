class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.string :street, limit: 50
      t.string :unit, limit: 5
      t.string :unit_label, limit: 5
      t.string :city, limit: 30
      t.string :zip, limit: 10
      t.string :state, limit: 2

      t.timestamps null: false
    end
  end
end
