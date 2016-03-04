class AddLocationToService < ActiveRecord::Migration
  def change
    add_column :services, :location, :string
  end
end
