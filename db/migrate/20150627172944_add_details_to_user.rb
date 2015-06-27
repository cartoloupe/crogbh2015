class AddDetailsToUser < ActiveRecord::Migration
  def change
    add_reference :users, :details, polymorphic: true, index: true, null: false
  end
end
