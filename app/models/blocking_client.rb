class BlockingClient < ActiveRecord::Base
  attr_accessible :blocking_client_id, :car_number, :lat, :long
  has_many :messages
end
