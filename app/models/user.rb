class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  belongs_to :details, polymorphic: true

  validates :first_name, presence: true
  validates :last_name,  presence: true
  validates :details,    valid:    true
end
