class AddCategoriesServicesJoinTable < ActiveRecord::Migration
  def self.up
    create_table :categories_services, id: false do |t|
      t.integer :category_id
      t.integer :service_id
    end
  end

  def self.down
    drop_table :categories_services
  end
end
