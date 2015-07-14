class CreateUser < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.references :details, polymorphic: true, index: true
      t.string :email
      t.string :password_digest
    end
  end
end
