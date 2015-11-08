class Service < ActiveRecord::Base
  validates :description, presence: true
  validates :name,        presence: true

  belongs_to :category
end
