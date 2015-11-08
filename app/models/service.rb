class Service < ActiveRecord::Base
  validates :description, presence: true
  validates :name,        presence: true

  has_and_belongs_to_many :categories
end
