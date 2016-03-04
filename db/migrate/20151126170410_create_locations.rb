class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.references :service, index: true
      t.string :name
      t.text :hours
      t.references :address, index: true

      t.timestamps null: false
    end
    add_foreign_key :locations, :services
  end
end
