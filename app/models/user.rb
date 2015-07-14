class User < ActiveRecord::Base
  has_secure_password

  belongs_to :details, polymorphic: true

  validates :first_name, presence: true
  validates :last_name,  presence: true
  validates :details,    valid:    true
end
