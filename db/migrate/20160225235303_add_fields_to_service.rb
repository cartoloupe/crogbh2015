class AddFieldsToService < ActiveRecord::Migration
  def change
    add_column :services, :phone, :string
    add_column :services, :other, :text
  end
end
