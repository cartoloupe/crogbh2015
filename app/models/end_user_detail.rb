class EndUserDetail < ActiveRecord::Base
  has_one :user

  validates :zip,   zip:   true
  validates :phone, phone: true
  validates :state, state: true
end
