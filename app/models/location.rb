class Location < ActiveRecord::Base
  belongs_to :service
  belongs_to :address
end
